require 'test_helper'

class CreateCommentTest < ActiveSupport::TestCase
  setup do
    @create_comment = CreateComment.create!()
  end

  test "create_comment 생성" do
    create_comment_id = @create_comment.id
    service = CreateCommentService.new(create_comment_id)
    pp service.build_create_comment(create_comment_id).attributes
  end
end
