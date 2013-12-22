class UndoManagedCms < ActiveRecord::Migration
  def up
  	drop_table :faculty_profiles
  	drop_table :faculty_users
  end

  def down
  end
end
