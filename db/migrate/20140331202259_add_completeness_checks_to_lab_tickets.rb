class AddCompletenessChecksToLabTickets < ActiveRecord::Migration
  def change
  	add_column :lab_tickets, :dateClosed, :datetime
  end
end
