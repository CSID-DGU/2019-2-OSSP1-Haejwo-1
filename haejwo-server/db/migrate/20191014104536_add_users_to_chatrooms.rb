class AddUsersToChatrooms < ActiveRecord::Migration[5.2]
  def change
    add_reference :chatrooms, :request_user, index: true
    add_reference :chatrooms, :perform_user, index: true
    add_foreign_key :chatrooms, :users, column: :request_user_id
    add_foreign_key :chatrooms, :users, column: :perform_user_id
  end
end
