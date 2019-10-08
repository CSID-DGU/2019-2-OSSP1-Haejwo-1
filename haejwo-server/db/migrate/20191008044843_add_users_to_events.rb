class AddUsersToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :performer, index: true
    add_foreign_key :events, :users, column: :performer_id
  end
end
