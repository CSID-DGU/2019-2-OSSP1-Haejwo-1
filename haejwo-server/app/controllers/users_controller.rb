class UsersController < ApplicationController
  before_action :authenticate_user!, only: :update
  skip_before_action :verify_authenticity_token, only: :token

  def mypage
    name = :name
    email = :email
    phone = :phone
  end

  def update
    current_user.update_attributes!(thumbnail_params)
  end

  def select_certification
  end

  def token
    Rails.logger.info("first")
    Rails.logger.info("second")
    begin
      current_user.update_attributes!(device_token: params[:token], device_type: params[:device_type])
    rescue => e
      Rails.logger.info e
    end
    Rails.logger.info("third")
    head 200
  end

  def check_email
    email = params[:email] if params[:email].present?
    already_exist = User.find_by(email: email).present?
    format_wrong = (email =~ /\A[^@\s]+@[^@\s]+\z/) != 0
    result = (already_exist || format_wrong)  ? 0 : 1
    render json: {result: result}
  end

  private

  def thumbnail_params
    params.require(:user).permit(:thumbnail)
  end
end
