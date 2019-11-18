class EmailCertification
  attr_reader :user, :params

  def initialize(user, params)
    @user = user
    @params = params
  end

  def exec
    ActiveRecord::Base.transaction do
      begin
        update_user_info
        send_certification_email
      rescue => e
        puts e
        Rails.logger.info e
      end
    end
  end

  private

  def update_user_info
    user.update!(
      certification_state: 'waiting',
      student_email: student_email,
      certification_token: certification_token
    )
  end

  def send_certification_email
    StudentMailer.certification_email(user: user).deliver_now
  end

  def student_email
    params.require(:user).permit(:student_email)[:student_email]
  end

  def certification_token
    SecureRandom.hex(30)
  end
end
