class UpdateUserModelToReflectTechModelChanges < ActiveRecord::Migration
  def up
  	add_column :users, :isSupervisorUser, :boolean
  	add_column :users, :isTechUser, :boolean
  	add_column :users, :isClientUser, :boolean
  	add_column :users, :departmentID, :integer
  	add_column :users, :locationID, :integer
  	add_column :users, :taskPoints, :integer
  end
end
