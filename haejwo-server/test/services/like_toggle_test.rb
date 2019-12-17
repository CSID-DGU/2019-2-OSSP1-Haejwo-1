require 'test_helper'

class LikeToggleTest < ActiveSupport::TestCase
  setup do
    @like_toggle = LikeToggle.create!()
  end

  test "like_toggle 생성" do
    like_toggle_id = @like_toggle.id
    service = LikeToggleService.new(like_toggle_id)
    pp service.build_like_toggle(like_toggle_id).attributes
  end
end
