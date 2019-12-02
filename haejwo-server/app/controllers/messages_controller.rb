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
        message_content: @message.content,
        username: @message.sender.name,
        thumbnail: @message.sender.thumbnail_url
      )
    @message.receiver.send_push('메세지 도착', @message.content)
    end
  end

  private
  def message_params
    {
      sender: current_user,
      receiver_id: params[:oppenentUserId],
      content: params[:msgContent]
    }
  end

  def load_chatroom
    @chatroom = Chatroom.find params[:chatroom_id]
  end
end
