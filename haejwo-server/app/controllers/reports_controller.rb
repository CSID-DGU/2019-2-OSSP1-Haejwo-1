class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params, only: %i[create]
  before_action :find_event, only: %i[new, create]

  def new
    @report = Report.new
  end

  def create
    if @event.performer == current_user
      @report = Report.create!(user: @event.user, event: @event)
    else
      @report = Report.create!(user: @event.performer, event: @event)
    end
    @report.user.blacklist = true
    @report.user.save
    @report.update(set_params)
  end

  private
  def set_params
    params.require(:report).permit(:content)
  end

  def find_event
    @event = Event.find params[:event_id]
  end
end
