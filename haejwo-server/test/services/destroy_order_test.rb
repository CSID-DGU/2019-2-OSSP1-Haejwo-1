require 'test_helper'

class DestroyOrderTest < ActiveSupport::TestCase
  setup do
    @destroy_order = DestroyOrder.create!()
  end

  test "destroy_order 생성" do
    destroy_order_id = @destroy_order.id
    service = DestroyOrderService.new(destroy_order_id)
    pp service.build_destroy_order(destroy_order_id).attributes
  end
end
