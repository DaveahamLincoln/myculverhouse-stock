class PrinterAssociation < ActiveRecord::Base
	belongs_to :equipment
  	attr_accessible :equipmentID, :printerID
  	validates_presence_of :equipmentID, :printerID
end
