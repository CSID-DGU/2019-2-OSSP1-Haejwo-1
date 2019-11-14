class AddStudentEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :student_email, :string
    add_column :users, :certification_token, :string
  end
end
