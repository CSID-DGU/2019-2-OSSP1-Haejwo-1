require 'test_helper'

class PerformEventTest < ActiveSupport::TestCase
  setup do
    @perform_event = PerformEvent.create!()
  end

  test "perform_event 생성" do
    perform_event_id = @perform_event.id
    service = PerformEventService.new(perform_event_id)
    pp service.build_perform_event(perform_event_id).attributes
  end
end
