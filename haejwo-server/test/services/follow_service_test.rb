require 'test_helper'

class FollowServiceTest < ActiveSupport::TestCase
  setup do
    @follow_service = FollowService.create!()
  end

  test "follow_service 생성" do
    follow_service_id = @follow_service.id
    service = FollowServiceService.new(follow_service_id)
    pp service.build_follow_service(follow_service_id).attributes
  end
end
