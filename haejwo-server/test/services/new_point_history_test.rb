require 'test_helper'

class NewPointHistoryTest < ActiveSupport::TestCase
  setup do
    @new_point_history = NewPointHistory.create!()
  end

  test "new_point_history 생성" do
    new_point_history_id = @new_point_history.id
    service = NewPointHistoryService.new(new_point_history_id)
    pp service.build_new_point_history(new_point_history_id).attributes
  end
end
