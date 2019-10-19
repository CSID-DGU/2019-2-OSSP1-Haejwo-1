class ChatroomsController < ApplicationController

  def index
    @chatrooms = Chatroom.where('request_user_id = :user_id OR perform_user_id = :user_id', user_id: current_user.id)
  end

  def new
  end

  # 채팅방 개설
  def create
    # @chatroom = Chatroom.new(@event)
    # @chatroom.request_user = params[:event][:user]
    # @chatroom.perform_user = params[:event][:performer]
    # @chatroom.save
    # redirect_to chatroom_path(@chatroom)
  end

  # 채팅방 상세보기
  def show
    @chatroom = Chatroom.find params[:id]
    # @message = Message.new
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
