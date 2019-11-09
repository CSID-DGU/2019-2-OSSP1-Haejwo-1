class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_chatroom

  def index
  end

  def create
    @message = @chatroom.messages.create!(message_params)
    if @message.save
      ActionCable.server.broadcast 'messages',
        message: @message.content,
        user: @message.user.name
      head :ok
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
