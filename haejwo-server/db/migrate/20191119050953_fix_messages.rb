class FixMessages < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages, :user_id, :sender_id
    add_reference :messages, :receiver, index: true
    add_foreign_key :messages, :users, column: :receiver_id
  end
end
