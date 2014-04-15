class Task < ActiveRecord::Base
  #This allows us to manage task creation much more easily.  For a better explanation of how this is done, 
  #check out
  #http://railscasts.com/episodes/17-habtm-checkboxes
  has_and_belongs_to_many :equipment
  attr_accessible :assignedTech, :completed, :description, :labTicketID, :completed
  
  #Adds opinio comment functionality to the model.
  opinio_subjectum
end
