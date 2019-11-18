class CreatePushes < ActiveRecord::Migration[5.2]
  def change
    create_table :pushes do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
