require 'test_helper'

class ImpressionTest < ActiveSupport::TestCase
  setup do
    @impression = Impression.create!()
  end

  test "impression 생성" do
    impression_id = @impression.id
    service = ImpressionService.new(impression_id)
    pp service.build_impression(impression_id).attributes
  end
end
