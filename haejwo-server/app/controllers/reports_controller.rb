class ReportsController < ApplicationController
  before_action :authenticate_user!

  def new
    # byebug
    @report = Report.new(event_id: id)
  end

  def create
    @event = @report.event
    if @event.performer == current_user
      @report.user = @event.user
      @event.performer.blacklist = true
    else
      @report.user = @event.performer
      @event.user.blacklist = true
    end
    @report = @report.create!(set_params)
    @report.save
  end

  private
  def set_params
    params.require(:report).permit(:event_id, :content)
  end
end
