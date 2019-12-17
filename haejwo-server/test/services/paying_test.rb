require 'test_helper'

class PayingTest < ActiveSupport::TestCase
  setup do
    @paying = Paying.create!()
  end

  test "paying 생성" do
    paying_id = @paying.id
    service = PayingService.new(paying_id)
    pp service.build_paying(paying_id).attributes
  end
end
