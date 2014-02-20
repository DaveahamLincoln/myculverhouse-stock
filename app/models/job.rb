class Job < ActiveRecord::Base
  belongs_to :trouble_ticket
  attr_accessible :completed, :completedByID, :description, :ticketID
  validates_presence_of :description, :ticketID
end