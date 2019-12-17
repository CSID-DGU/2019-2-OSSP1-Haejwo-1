class Pay
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def get_prices
    delete_disabled_item
    items_total = items_total
    shipping_fee = shipping_fee
    total = items_total + shipping_fee
    return [
      items_total,
      shipping_fee,
      total
    ]
  end

  def is_payable
    (line_items.enough_stock && (%w(cart direct).include?(order.state))) ? true : false
  end

  private
  def line_items
    order.line_items
  end

  def items_total
    total = 0
    line_items.includes(:item).find_each do |line_item|
      item = line_item.item
      total += line_item.quantity * line_item.option.additional_price if item.present?
    end
    total
  end

  def delete_disabled_item
    line_items.find_each do |line_item|
      line_item.destroy if line_item.item.disabled?
    end
  end

  def shipping_fee
    result = 0
    brand_line_items_hash = line_items.group_by {|i| i.item.brand.id}
    brand_line_items_hash.each do |brand_id, groupped_line_items|
      brand = Brand.find(brand_id)
      if brand.conditional? && (get_total(groupped_line_items) < brand.free_standard)
        result += brand.shipping_fee
      elsif brand.fixed?
        result += brand.shipping_fee
      end
    end
    result
  end

  def get_total(groupped_line_items)
    total = 0
    groupped_line_items.each do |line_item|
      item = line_item.item
      total += line_item.quantity * line_item.option.additional_price if item.present?
    end
    total
  end
end
