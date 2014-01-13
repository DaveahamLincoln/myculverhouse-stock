class AddCmsSiteEnabledBitToFacultyUsers < ActiveRecord::Migration
  def change
  	add_column :faculty_users,:cms_site_enabled,:boolean, :default => 0
  end

  def down
  	raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end

