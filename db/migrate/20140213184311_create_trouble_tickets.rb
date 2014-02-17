class CreateTroubleTickets < ActiveRecord::Migration
  def change
    create_table :trouble_tickets do |t|
      t.integer :locationID
      t.integer :equipmentID
      t.integer :programID
      t.string :problemDescription
      t.integer :status
      t.datetime :dateScheduled
      t.integer :clientID
      t.integer :requestedBy
      t.integer :receivingTech
      t.integer :assignedTech
      t.boolean :assignedTechConfirmed
      t.integer :supervisorID
      t.datetime :dateClosed
      t.string :techNotes
      t.integer :urgency
      t.string :resolution

      t.timestamps
    end
  end
end
