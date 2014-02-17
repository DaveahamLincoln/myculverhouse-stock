class AddClosingtechToTroubleTickets < ActiveRecord::Migration
  def change
  	add_column :trouble_tickets, :closingTech, :integer
  end
end
