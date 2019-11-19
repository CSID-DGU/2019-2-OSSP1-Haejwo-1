class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_chatroom

  def index
  end

  def create
    @message = @chatroom.messages.create!(message_params)
    if @message.present?
      ActionCable.server.broadcast(
        "user_#{@받는놈 아이디}_channel",
        broad_type: 'message',
        message: @message.content,
        user: @message.user.name
      )
    end
  end

  private
  def message_params
    params[:message][:user_id] = current_user.id
    params.require(:message).permit(:user_id, :content)
  end

  def load_chatroom
    @chatroom = Chatroom.find params[:chatroom_id]
  end
end
