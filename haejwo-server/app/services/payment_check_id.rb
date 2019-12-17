class PaymentCheckId
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def exec
    if order.paid? || order.ready?
      ActiveRecord::Base.transaction do
        create_new_deliveries
        order.checked!
        deposit_update if order.deposited?
      end
    else
      raise 'error'
    end
  end

  private
  def line_items
    order.line_items
  end

  def brand_line_items_hash
    line_items.group_by {|i| i.item.brand.id}
  end

  def uniq_delivery_number
    delivery_number = ''
    loop do
      delivery_number = SecureRandom.hex(8).upcase
      break unless Delivery.find_by(delivery_number: delivery_number).present?
    end
    delivery_number
  end

  def create_new_deliveries
    brand_line_items_hash.each do |brand_id, brand_line_items|
      brand = Brand.find(brand_id)
      shipping_fee = brand.shipping_fee
      total = get_total(brand_line_items)
      shipping_fee = 0 if brand.conditional? && (total >= brand.free_standard)
      total += shipping_fee
      delivery = Delivery.create!(
        order: order,
        brand: brand,
        total: total,
        delivery_number: uniq_delivery_number,
        shipping_fee: shipping_fee
      )
      update_my_line_items(brand_line_items, delivery)
    end
  end

  def get_total(brand_line_items)
    total = 0
    brand_line_items.each do |line_item|
      total += line_item.quantity * line_item.option.additional_price if item = line_item.item
    end
    total
  end

  def update_my_line_items(brand_line_items, delivery)
    brand_line_items.each do |line_item|
      line_item.update_attributes!(delivery: delivery)
    end
  end

  def deposit_update
    will_point_total = order.total / Item::WILL_POINT_PER
    new_point_history = NewPointHistory.new(order.user, will_point_total, :accumulate, order)
    new_point_history.generate
  end
end
