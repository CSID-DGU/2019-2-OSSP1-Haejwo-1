class AddCertiStateToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :certification_state, :integer
  end
end
