class CreateProgramAssociations < ActiveRecord::Migration
  def change
    create_table :program_associations do |t|
      t.integer :equipmentID
      t.integer :programID

      t.timestamps
    end
  end
end
