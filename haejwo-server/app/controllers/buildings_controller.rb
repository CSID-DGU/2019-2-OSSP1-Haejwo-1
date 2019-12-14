class BuildingsController < ApplicationController
  before_action :set_building, only: :show

  def show
    @events = @building.events
                       .matching
                       .order(created_at: :desc)
  end

  private

  def set_building
    @building = Building.find(params[:id])
  end
end
