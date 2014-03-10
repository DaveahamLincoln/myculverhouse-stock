class LabTicket < ActiveRecord::Base
  attr_accessible :clientID, :dateScheduled, :locationID, :problemDescription, :programID, :receivingTech, :requestedBy, :resolution, :status, :supervisorID, :techNotes, :urgency
end
