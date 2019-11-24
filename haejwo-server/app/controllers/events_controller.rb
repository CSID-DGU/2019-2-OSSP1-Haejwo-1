class EventsController < ApplicationController
  before_action :authenticate_user!
	before_action :load_event, only: %i[show edit update destroy perform]
  before_action :load_selectors, only: %i[new edit]

	def index
		@events = Event.all.order("created_at DESC")
	end

	# 심부름 생성하기
	def new
		@event = Event.new
	end

	def create
		@event = current_user.events.create!(event_params)
    @event.tag_list.add(params[:event][:tag_list], parse: true)
    @event.save
	end

	# 심부름 상세보기
	def show
	end

	# 심부름 수정
	def edit
	end

	def update
		@event.update!(event_params)
	end

	# 심부름 삭제
	def destroy
		@event.destroy
	end

  # 심부름 수행
  def perform
    perform_event = PerformEvent.new(@event, current_user)
    chatroom = perform_event.execute
    @event.user.send_push('심부름 요청 수락', '요청하신 심부름이 수락되었습니다.')
    render json: {chatroomId: chatroom.id}
  end

  def check_valid
    changed_event = current_user.events.new(event_params)
    @valid = changed_event.valid?
    @msg = changed_event.errors.full_messages[0] if !@valid
  end

	private

	def load_event
		@event = Event.find params[:id]
	end

	def event_params
		params.require(:event).permit(:building_id, :title, :place, :detail_place, :time_limit, :content, :reward)
	end

  def load_selectors
    @building_selectors = Building.order(name: :asc).map {|building| [building.name, building.id]}
    @reward_selectors = Event.reward_selectors
  end
end
