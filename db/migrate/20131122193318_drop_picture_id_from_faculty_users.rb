class DropPictureIdFromFacultyUsers < ActiveRecord::Migration
  def up
  	remove_column :faculty_users, :userPictureID
  end

  def down
  end
end
