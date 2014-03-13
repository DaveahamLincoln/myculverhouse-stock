class Task < ActiveRecord::Base
  has_and_belongs_to_many :equipment
  attr_accessible :assignedTech, :completed, :description, :labTicketID, :completed
  opinio_subjectum
end
