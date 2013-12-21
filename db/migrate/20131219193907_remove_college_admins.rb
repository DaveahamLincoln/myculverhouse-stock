class RemoveCollegeAdmins < ActiveRecord::Migration
  def change
    drop_table :college_admins
  end
end