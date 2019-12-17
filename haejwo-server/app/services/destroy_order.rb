class DestroyOrder
  include Iamport
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def exec
    ActiveRecord::Base.transaction do
      reset_option_quantities
      @order.destroy # reset_point_history by dependent: :destroy
      iamport_cancel(order.order_number, order.total)
    end
  end

  private
  def reset_option_quantities
    order.line_items.includes(:option).find_each do |line_item|
      option = line_item.option
      option.update_attributes!(quantity: option.quantity + line_item.quantity) if option.present?
    end
  end
end
