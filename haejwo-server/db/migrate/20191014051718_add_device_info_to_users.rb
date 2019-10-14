class AddDeviceInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :device_token, :string
    add_column :users, :device_type, :integer
  end
end
