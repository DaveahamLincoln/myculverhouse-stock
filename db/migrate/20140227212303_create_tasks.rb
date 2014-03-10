class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :labTicketID
      t.string :description
      t.integer :assignedTech
      t.boolean :completed

      t.timestamps
    end
  end
end
