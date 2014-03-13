class AddClosingTechToLabTickets < ActiveRecord::Migration
  def change
  	add_column :lab_tickets, :closingTech, :integer
  end
end