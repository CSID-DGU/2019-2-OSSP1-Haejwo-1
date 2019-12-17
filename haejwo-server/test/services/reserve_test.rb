require 'test_helper'

class ReserveTest < ActiveSupport::TestCase
  setup do
    @reserve = Reserve.create!()
  end

  test "reserve 생성" do
    reserve_id = @reserve.id
    service = ReserveService.new(reserve_id)
    pp service.build_reserve(reserve_id).attributes
  end
end
