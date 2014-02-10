class ProgramAssociation < ActiveRecord::Base
  	belongs_to :equipment
  	attr_accessible :equipmentID, :programID
  	validates_presence_of :equipmentID, :programID
end
