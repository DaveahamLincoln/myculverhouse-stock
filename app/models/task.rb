class Task < ActiveRecord::Base
  attr_accessible :assignedTech, :completed, :description, :labTicketID
end
