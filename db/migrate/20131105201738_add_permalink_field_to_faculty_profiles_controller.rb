class AddPermalinkFieldToFacultyProfilesController < ActiveRecord::Migration
  def change
  	add_column :faculty_profiles,:permalink,:string
  end
end
