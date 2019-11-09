class ReportsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @chatroom = Chatroom.find params[:chatroom_id]
    @event = @chatroom.event
    @report = Report.new
  end

  def create
    @report = Report.create!(set_params)
    if @report.event.performer == current_user
      @report.user = @report.event.user
    else
      @report.user = @report.event.performer
    end
    @report.save
  end

  private
  def set_params
    params.require(:report).permit(:event_id, :content)
  end
end
