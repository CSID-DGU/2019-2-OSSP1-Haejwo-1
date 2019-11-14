class StudentMailer < ApplicationMailer
  default from: 'heajwo@rails.kr'

  def certification_email(user)
    @user = user
    mail(to: [user.certification_email], subject: '[Haejwo(해줘)] 인증메일 도착!')
  end
end
