class CreateLabTickets < ActiveRecord::Migration
  def change
    create_table :lab_tickets do |t|
      t.integer :locationID
      t.integer :programID
      t.string :problemDescription
      t.integer :status
      t.datetime :dateScheduled
      t.integer :clientID
      t.integer :requestedBy
      t.integer :receivingTech
      t.integer :supervisorID
      t.string :techNotes
      t.integer :urgency
      t.string :resolution

      t.timestamps
    end
  end
end
