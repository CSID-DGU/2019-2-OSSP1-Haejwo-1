class BuildingsController < ApplicationController
  before_action :set_building, only: :show

  def show
    @events = @building.events
                       .matching
                       .where('time_limit >= ?', Time.current)
                       .order(:time_limit)
  end

  private

  def set_building
    @building = Building.find(params[:id])
  end
end
