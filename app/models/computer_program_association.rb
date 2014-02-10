class ComputerProgramAssociation < ActiveRecord::Base
  	belongs_to :equipment
  	attr_accessible :equipmentID, :computerProgramID
  	validates_presence_of :equipmentID, :computerProgramID
end
