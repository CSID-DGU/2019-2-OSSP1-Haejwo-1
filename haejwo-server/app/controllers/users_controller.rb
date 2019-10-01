class UsersController < ApplicationController
  before_action :authenticate_user!, only: :update

  def mypage
  end

  def update
    current_user.update_attributes!(thumbnail_params)
  end

  private
  
  def thumbnail_params
    params.require(:user).permit(:thumbnail)
  end
end
