class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :report_params, only: %i[create]
  before_action :find_event, only: %i[new, create]

  def new
    @report = Report.new
  end

  def create
    r_params = report_params
    r_params[:event] = @event
    if @event.performer == current_user
      r_params[:user] = @event.user
      @report = Report.create!(r_params)
    else
      r_params[:user] = @event.performer
      @report = Report.create!(user: @event.performer, event: @event)
    end
  end

  def check_valid
    report = Report.new(report_params)
    report.event = @event
    if @event.performer == current_user
      report.user = @event.user
    else
      report.user = @event.performer
    end

    @valid = report.valid?
    @msg = report.errors.full_messages[0] if !@valid
  end

  private
  def report_params
    params.require(:report).permit(:content)
  end

  def find_event
    @event = Event.find params[:event_id]
  end
end
