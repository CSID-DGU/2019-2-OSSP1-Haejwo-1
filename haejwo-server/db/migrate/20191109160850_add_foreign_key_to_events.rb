class AddForeignKeyToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :building, foreign_key: true
  end
end
