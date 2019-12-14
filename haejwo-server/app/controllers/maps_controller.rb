class MapsController < ApplicationController
  def index
    @buildings = Building.joins(:events)
                         .select('buildings.*, COUNT("events") matching_events_count')
                         .where(events: {state: 'matching'})
                         .group('buildings.id')
  end
end
