class Iamport
  attr_reader :code, :iamport_response, :merchant_uid

  def initialize(code, iamport_response, merchant_uid)
    @code = code
    @iamport_response = iamport_response
    @merchant_uid = merchant_uid
  end

  def exec
    if code == 0 && iamport_response.present? && iamport_response['paid_at'] != 0
      find_order_and_update_paid
    end
  end

  private
  def find_order_and_update_paid
    order = Order.where(order_number: merchant_uid).first
    order.paid!
  end
end
