class ModifyImageTrackingPropertiesInComputerPrograms < ActiveRecord::Migration
  def up
  	add_column :computer_programs, :classroomImage, :boolean
  	add_column :computer_programs, :econImage, :boolean
  	add_column :computer_programs, :labImage, :boolean
  end

  def down
  	add_column :computer_programs, :status, :integer
  end
end
