require 'test_helper'

class OrderGetTest < ActiveSupport::TestCase
  setup do
    @order_get = OrderGet.create!()
  end

  test "order_get 생성" do
    order_get_id = @order_get.id
    service = OrderGetService.new(order_get_id)
    pp service.build_order_get(order_get_id).attributes
  end
end
