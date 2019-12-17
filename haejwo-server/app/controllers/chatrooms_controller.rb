class ChatroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chatrooms = Chatroom.joins(:messages)
                         .where('request_user_id = :user_id OR perform_user_id = :user_id', user_id: current_user.id)
                         .includes(:request_user, :event, messages: :sender)
                         .group('chatrooms.id')
                         .order('max(messages.created_at) desc')
  end

  # 채팅방 상세보기
  def show
    @chatroom = Chatroom.find params[:id]
    @message = Message.new
    @messages = @chatroom.messages
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
