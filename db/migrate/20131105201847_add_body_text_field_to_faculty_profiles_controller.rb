class AddBodyTextFieldToFacultyProfilesController < ActiveRecord::Migration
  def change
  	add_column :faculty_profiles,:bodyText,:text
  end
end
