require 'test_helper'

class PayTest < ActiveSupport::TestCase
  setup do
    @pay = Pay.create!()
  end

  test "pay 생성" do
    pay_id = @pay.id
    service = PayService.new(pay_id)
    pp service.build_pay(pay_id).attributes
  end
end
