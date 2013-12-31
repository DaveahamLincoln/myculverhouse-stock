class AddCmsSiteIdToFacultyUsers < ActiveRecord::Migration
  def change
  	add_column :faculty_users,:cms_site_id,:integer
  end
end

