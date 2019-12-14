class BuildingsController < ApplicationController
  before_action :set_building, only: :show

  def show
    @events = @building.events
                       .not_performed
                       .order(created_at: :desc)
  end

  private

  def set_building
    @building = Building.find(params[:id])
  end
end
