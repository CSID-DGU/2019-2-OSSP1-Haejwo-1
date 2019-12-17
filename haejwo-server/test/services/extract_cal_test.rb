require 'test_helper'

class ExtractCalTest < ActiveSupport::TestCase
  setup do
    @extract_cal = ExtractCal.create!()
  end

  test "extract_cal 생성" do
    extract_cal_id = @extract_cal.id
    service = ExtractCalService.new(extract_cal_id)
    pp service.build_extract_cal(extract_cal_id).attributes
  end
end
