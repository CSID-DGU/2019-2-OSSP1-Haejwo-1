require 'test_helper'

class PayIampTest < ActiveSupport::TestCase
  setup do
    @pay_iamp = PayIamp.create!()
  end

  test "pay_iamp 생성" do
    pay_iamp_id = @pay_iamp.id
    service = PayIampService.new(pay_iamp_id)
    pp service.build_pay_iamp(pay_iamp_id).attributes
  end
end
