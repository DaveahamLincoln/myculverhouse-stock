class CreateCommunicationsUsers < ActiveRecord::Migration
  def change
    create_table :communications_users do |t|
      t.integer :userID

      t.timestamps
    end
  end
end
