require 'test_helper'

class CalculateOrderTotalTest < ActiveSupport::TestCase
  setup do
    @calculate_order_total = CalculateOrderTotal.create!()
  end

  test "calculate_order_total 생성" do
    calculate_order_total_id = @calculate_order_total.id
    service = CalculateOrderTotalService.new(calculate_order_total_id)
    pp service.build_calculate_order_total(calculate_order_total_id).attributes
  end
end
