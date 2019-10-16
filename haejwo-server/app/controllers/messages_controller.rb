class MessagesController < ApplicationController

  def index
  end

  def create
    @message = current_user.message.create!(message_params)
  end

  private
  def message_params
    params.require(:message).permit(:content, :chatroom_id)
  end
end
