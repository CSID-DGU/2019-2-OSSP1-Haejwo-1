class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :place
      t.string :detail_place
      t.datetime :time_limit
      t.text :content
      t.integer :state, default: 0
      t.integer :reward, default: 0

      t.timestamps
    end
  end
end
