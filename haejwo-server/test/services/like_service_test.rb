require 'test_helper'

class LikeServiceTest < ActiveSupport::TestCase
  setup do
    @like_service = LikeService.create!()
  end

  test "like_service 생성" do
    like_service_id = @like_service.id
    service = LikeServiceService.new(like_service_id)
    pp service.build_like_service(like_service_id).attributes
  end
end
