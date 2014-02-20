class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :ticketID
      t.string :description
      t.boolean :completed, :default => 0
      t.integer :completedByID

      t.timestamps
    end
  end
end
