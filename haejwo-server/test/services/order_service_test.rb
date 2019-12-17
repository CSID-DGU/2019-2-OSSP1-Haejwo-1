require 'test_helper'

class OrderServiceTest < ActiveSupport::TestCase
  setup do
    @order_service = OrderService.create!()
  end

  test "order_service 생성" do
    order_service_id = @order_service.id
    service = OrderServiceService.new(order_service_id)
    pp service.build_order_service(order_service_id).attributes
  end
end
