class MessagesController < ApplicationController

  def index
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      ActionCable.server.broadcast 'messages',
        message: message.content,
        user: message.user.name
      head :ok
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :chatroom_id)
  end
end
