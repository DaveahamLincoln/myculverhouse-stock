class AddClosingTechToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :closingTech, :integer
  end
end
