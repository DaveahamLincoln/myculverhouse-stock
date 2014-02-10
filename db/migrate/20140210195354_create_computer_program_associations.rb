class CreateComputerProgramAssociations < ActiveRecord::Migration
  def change
    create_table :computer_program_associations do |t|
      t.integer :equipmentID
      t.integer :computerProgramID

      t.timestamps
    end
  end
end