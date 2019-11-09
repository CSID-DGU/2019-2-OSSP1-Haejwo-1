class AddEventsCountToBuildings < ActiveRecord::Migration[5.2]
  def change
    add_column :buildings, :events_count, :integer, default: 0
  end
end
