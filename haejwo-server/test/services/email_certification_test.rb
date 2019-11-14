require 'test_helper'

class EmailCertificationTest < ActiveSupport::TestCase
  setup do
    @email_certification = EmailCertification.create!()
  end

  test "email_certification 생성" do
    email_certification_id = @email_certification.id
    service = EmailCertificationService.new(email_certification_id)
    pp service.build_email_certification(email_certification_id).attributes
  end
end
