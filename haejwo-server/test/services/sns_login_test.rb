require 'test_helper'

class SnsLoginTest < ActiveSupport::TestCase
  setup do
    @sns_login = SnsLogin.create!()
  end

  test "sns_login 생성" do
    sns_login_id = @sns_login.id
    service = SnsLoginService.new(sns_login_id)
    pp service.build_sns_login(sns_login_id).attributes
  end
end
