class UsersController < ApplicationController
  before_action :authenticate_user!, only: :update

  def mypage
    name = :name
    email = :email
    phone = :phone
  end

  def update
    current_user.update_attributes!(thumbnail_params)
  end

  def token
    user = User.find(params[:id])
    user.update_attributes!(device_token: params[:token], device_type: params[:device_type])
    head 200
  end

  private

  def thumbnail_params
    params.require(:user).permit(:thumbnail)
  end
end
