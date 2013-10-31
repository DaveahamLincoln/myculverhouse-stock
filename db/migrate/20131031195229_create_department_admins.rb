class CreateDepartmentAdmins < ActiveRecord::Migration
  def change
    create_table :department_admins do |t|

      t.timestamps
    end
  end
end
