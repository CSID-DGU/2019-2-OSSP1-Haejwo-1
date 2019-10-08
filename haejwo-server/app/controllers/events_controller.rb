class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
	before_action :load_event, only: [:show, :edit, :update, :destroy, :perform]

	def index
		@events = Event.all
	end

	# 심부름 생성하기
	def new
		@event = Event.new
	end

	def create
		@event = current_user.events.create!(set_params)
	end

	# 심부름 상세보기
	def show
	end

	# 심부름 수정
	def edit
	end

	def update
		@event.update!(set_params)
    redirect_to root_path
	end

	# 심부름 삭제
	def destroy
		@event.destroy
		redirect_to root_path
	end

  # 심부름 수행
  def perform
    @event.performer_id = current_user.id
    @event.state = 1
    @event.save
    redirect_to root_path
  end

	private
	def load_event
		@event = Event.find params[:id]
	end

	def set_params
		params.require(:event).permit(:title, :place, :detail_place, :time_limit, :content, :reward)
	end
end
