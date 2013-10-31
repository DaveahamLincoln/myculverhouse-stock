class CreateCollegeAdmins < ActiveRecord::Migration
  def change
    create_table :college_admins do |t|
      t.integer :userID

      t.timestamps
    end
  end
end
