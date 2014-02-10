class CreateComputerPrograms < ActiveRecord::Migration
  def change
    create_table :computer_programs do |t|
      t.string :name
      t.string :description
      t.string :publisher
      t.string :vendor
      t.string :serial
      t.string :license
      t.integer :licenseCount
      t.datetime :expDate
      t.string :uaAccountNo
      t.string :installNotes
      t.string :testingNotes
      t.string :accountNotes
      t.integer :userID
      t.integer :status

      t.timestamps
    end
  end
end