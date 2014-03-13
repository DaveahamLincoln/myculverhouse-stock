class AddCompoundIndexToEquipmentTasks < ActiveRecord::Migration
  def change
  	 add_index :equipment_tasks, [:equipment_id, :task_id]
  end
end