class OrderService
  attr_reader :cart_item_, :_quantity, :price

  def initialize(cart_item_, _quantity, price)
    @cart_item_ = cart_item_
    @_quantity = _quantity
    @price = price
  end

  def get_price_and_shipping_fee
    if @_quantity > 0
      cart_item_.update_attributes!(_quantity: _quantity)
      results = get_totals
      results << ActionController::Base.helpers.number_to_currency(price * _quantity)
      results
    end
  end

  private
  def order
    cart_item_.order
  end

  def get_totals
    order_pay = OrderPay.new(order)
    order_pay.get_prices
  end
end
