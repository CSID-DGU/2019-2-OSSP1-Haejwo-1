class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @chatrooms = Chatroom.where('request_user_id = :user_id OR perform_user_id = :user_id', user_id: current_user.id)
  end
end
