class Paying
  attr_reader :event, :event_params, :c_t

  def initialize(event, event_params)
    @event = event
    @event_params = event_params
    @c_t = Time.current
  end

  def paying_success?
    if pushs.enough_stock && %w(cart direct).include?(event.state) && (event.user.point >= event_params[:point].to_i)
      begin
        ActiveRecord::Base.transaction do
          u_i_p
          u_i_o
          update_event_info
          use_point
        end
      rescue => e
        puts e
        return false
      end
      return true
    else
      return false
    end
  end

  private
  def pushs
    event.pushs
  end

  def u_i_p
    pushs.find_each do |push|
      push_price = push.option.additional_price
      push.update_attributes(
        price: push_price,
        total: push_price * push.quant
      )
    end
  end

  def u_i_o
    pushs.find_each do |push|
      if option = push.option
        option.update_attributes(quant: (option.quant - push.quant))
      end
      if item = push.item
        item.sold_out! if item.check_sold_out?
      end
    end
  end

  def update_event_info
    event.update_attributes!(get_event_params)
  end

  def point
    event_params[:point].present? ? event_params[:point].to_i : 0
  end

  def get_event_params
    event_pay = OrderPay.new(event)
    item_total, shipping_fee, total, will_point_total = event_pay.get_prices
    total -= point
    raise 'error' if total < 0
    event_params[:quant] = pushs.sum(:quant)
    event_params[:paid_at] = c_t
    event_params[:total_without_shipping] = total - shipping_fee
    event_params[:total] = total
    event_params[:point] = point
    event_params[:state] = 'ready' if event_params[:payment_method] == 'deposit'
    event_params
  end

  def use_point
    new_point_history = NewPointHistory.new(event.user, point, :usage, event)
    new_point_history.generate
  end
end
