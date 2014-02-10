class Location < ActiveRecord::Base
	has_many :equipment
	has_many :lab_tickets
  	attr_accessible :name, :notes
  	validates_presence_of :name
end
