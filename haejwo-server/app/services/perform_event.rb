class PerformEvent
  attr_reader :event, :current_user

  def initialize(event, current_user)
    @event = event
    @current_user = current_user
  end

  def execute
    ActiveRecord::Base.transaction do
      begin
        update_event # 이벤트 수정
        chatroom = create_chatroom # 채팅방 생성
        chatroom
      rescue => e
        puts(e)
        Rails.logger.info(e)
      end
    end
  end

  private

  def update_event
    event.update_attributes!(
      performer: current_user,
      state: 'matched'
    )
  end

  def create_chatroom
    chatroom = Chatroom.create!(
      request_user: event.user,
      perform_user: event.performer,
      event: event)
    chatroom
  end
end
