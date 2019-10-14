class AddDefaultToCertificationState < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :certification_state, :integer, default: 0
  end
end
