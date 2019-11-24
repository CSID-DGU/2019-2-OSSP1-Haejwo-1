class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_chatroom

  def index
  end

  def create
    @message = @chatroom.messages.create!(message_params)
    if @message.present?
      ActionCable.server.broadcast(
        "user_#{@message.receiver.id}_channel",
        broad_type: 'message',
        message: @message.content,
        user: @message.sender.name
      )
    end
    @message.receiver.send_push('메세지 도착', @message.content)
    @chatroom.touch
  end

  private
  def message_params
    if @chatroom.request_user = current_user
      params[:message][:receiver_id] = @chatroom.perform_user.id
    else
      params[:message][:receiver_id] = @chatroom.request_user.id
    end
    params[:message][:sender_id] = current_user.id
    params.require(:message).permit(:sender_id, :receiver_id, :content)
  end

  def load_chatroom
    @chatroom = Chatroom.find params[:chatroom_id]
  end
end
