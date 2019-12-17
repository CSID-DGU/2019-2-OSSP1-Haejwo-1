class OrderGet
  attr_reader :_user

  def initialize(_user)
    @_user = _user
  end

  def cart
    if order = _user.orders&.cart.first
      order
    else
      order = _user.orders&.cart.create!(order_number_hash)
    end
  end

  def direct
    if order = _user.orders&.direct.first
      order.destroy
    end
    order = _user.orders&.direct.create!(order_number_hash)
  end

  private
  def order_number_hash
    loop do
      @order_number = SecureRandom.hex(8).upcase
      break unless Order.find_by(order_number: @order_number).present?
    end
    {order_number: @order_number}
  end
end
