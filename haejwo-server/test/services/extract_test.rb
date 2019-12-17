require 'test_helper'

class ExtractTest < ActiveSupport::TestCase
  setup do
    @extract = Extract.create!()
  end

  test "extract 생성" do
    extract_id = @extract.id
    service = ExtractService.new(extract_id)
    pp service.build_extract(extract_id).attributes
  end
end
