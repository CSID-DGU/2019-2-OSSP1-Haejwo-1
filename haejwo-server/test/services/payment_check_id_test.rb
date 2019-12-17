require 'test_helper'

class PaymentCheckIdTest < ActiveSupport::TestCase
  setup do
    @payment_check_id = PaymentCheckId.create!()
  end

  test "payment_check_id 생성" do
    payment_check_id_id = @payment_check_id.id
    service = PaymentCheckIdService.new(payment_check_id_id)
    pp service.build_payment_check_id(payment_check_id_id).attributes
  end
end
