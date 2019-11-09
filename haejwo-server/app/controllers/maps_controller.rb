class MapsController < ApplicationController
  def index
    @buildings = Building.includes(:events)
  end
end
