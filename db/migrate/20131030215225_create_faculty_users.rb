class CreateFacultyUsers < ActiveRecord::Migration
  def change
    create_table :faculty_users do |t|
      t.integer :userID
      t.integer :facultyPageID
      t.integer :userPictureID

      t.timestamps
    end
  end
end
