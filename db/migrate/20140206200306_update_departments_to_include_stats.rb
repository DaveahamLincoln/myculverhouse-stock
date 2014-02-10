class UpdateDepartmentsToIncludeStats < ActiveRecord::Migration
  def up
  	add_column :departments,:fax,:string
  	add_column :departments,:office,:string
  	add_column :departments,:building,:string
  	add_column :departments,:poBox,:string
  end
end
