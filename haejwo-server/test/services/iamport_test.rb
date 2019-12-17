require 'test_helper'

class IamportTest < ActiveSupport::TestCase
  setup do
    @iamport = Iamport.create!()
  end

  test "iamport 생성" do
    iamport_id = @iamport.id
    service = IamportService.new(iamport_id)
    pp service.build_iamport(iamport_id).attributes
  end
end
