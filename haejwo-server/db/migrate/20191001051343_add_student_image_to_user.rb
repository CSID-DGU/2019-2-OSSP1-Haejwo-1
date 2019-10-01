class AddStudentImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :student_card_image, :string
  end
end
