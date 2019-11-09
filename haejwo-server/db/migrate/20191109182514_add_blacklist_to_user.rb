class AddBlacklistToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :blacklist, :boolean, default: false
  end
end
