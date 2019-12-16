class MapsController < ApplicationController
  def index
    @buildings = Building.joins(:events)
                         .select('buildings.*, COUNT("events") matching_events_count')
                         .where('events.state = ? AND events.time_limit >= ?', 0, Time.current)
                         .group('buildings.id')
  end
  #.where(events: {state: 'matching'})
end
