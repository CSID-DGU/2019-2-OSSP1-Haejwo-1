require 'test_helper'

class RefundTest < ActiveSupport::TestCase
  setup do
    @refund = Refund.create!()
  end

  test "refund 생성" do
    refund_id = @refund.id
    service = RefundService.new(refund_id)
    pp service.build_refund(refund_id).attributes
  end
end
