class RechangeFacultyPageIdToFacultyProfileId < ActiveRecord::Migration
  def up
  	rename_column :faculty_users, :facultyPageID, :facultyProfileID
  end

  def down
  end
end