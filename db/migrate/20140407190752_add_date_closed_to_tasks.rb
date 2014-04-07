class AddDateClosedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :dateClosed, :datetime
  end
end
