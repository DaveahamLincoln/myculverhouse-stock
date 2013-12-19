class RemoveDepartmentAdmins < ActiveRecord::Migration
  def change
    drop_table :department_admins
  end
end
