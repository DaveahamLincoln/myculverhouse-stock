class ComputerProgram < ActiveRecord::Base
  attr_accessible :accountNotes, :description, :expDate, :installNotes, :license, :licenseCount, :name, :publisher, :serial, :status, :testingNotes, :uaAccountNo, :userID, :vendor
  validates_presence_of :description, :name, :publisher, :serial, :status

  def digest
  	"#{self.name} - #{self.serial}"
  end
end
