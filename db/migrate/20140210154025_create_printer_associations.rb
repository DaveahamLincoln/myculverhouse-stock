class CreatePrinterAssociations < ActiveRecord::Migration
  def change
    create_table :printer_associations do |t|
      t.integer :equipmentID
      t.integer :printerID

      t.timestamps
    end
  end
end
