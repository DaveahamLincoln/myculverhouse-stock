class AddPermissionsFieldsToUserTable < ActiveRecord::Migration
  def change
  	  	add_column :Users, :isSuperUser,:boolean
  	  	add_column :Users, :isGenericUser,:boolean
  	  	add_column :Users, :isFacultyUser,:boolean
  end
end
