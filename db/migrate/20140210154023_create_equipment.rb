class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.integer :locationID
      t.string :serial
      t.integer :status
      t.integer :departmentID
      t.string :description

      t.timestamps
    end
  end
end