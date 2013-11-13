class AddPermissionsFieldsToUserTable < ActiveRecord::Migration
  def change
  	  	add_column :users, :isSuperUser,:boolean
  	  	add_column :users, :isGenericUser,:boolean
  	  	add_column :users, :isFacultyUser,:boolean
  	  	add_column :users, :isCommunicationsUser,:boolean
  end
end
