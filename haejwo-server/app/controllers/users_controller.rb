class UsersController < ApplicationController
  # before_action :authenticate_user!, only: :update
  before_action :user_params, only: [:edit, :update]
  skip_before_action :verify_authenticity_token, only: :token

  def mypage
    @user = current_user
  end

  def edit
  end

  def update
    current_user.update!(user_params)
    redirect_to mypage_path
  end

  def select_certification
  end

  def token
    Rails.logger.info('generate a new token')
    user = User.find(params[:id])
    user.update_attributes!(device_token: params[:token], device_type: params[:device_type])
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

  def user_params
    params.require(:user).permit(:name, :email, :phone, :thumbnail, :address1, :address2, :zipcode)
  end
end
