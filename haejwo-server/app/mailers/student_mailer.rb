class StudentMailer < ApplicationMailer
  default from: 'heajwo@dongguk.edu'

  def certification_email(user)
    @user = user[:user]
    mail(to: @user.student_email, subject: '[Haejwo(해줘)] 인증메일 도착!')
  end
end
