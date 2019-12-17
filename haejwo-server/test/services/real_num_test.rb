require 'test_helper'

class RealNumTest < ActiveSupport::TestCase
  setup do
    @real_num = RealNum.create!()
  end

  test "real_num 생성" do
    real_num_id = @real_num.id
    service = RealNumService.new(real_num_id)
    pp service.build_real_num(real_num_id).attributes
  end
end
