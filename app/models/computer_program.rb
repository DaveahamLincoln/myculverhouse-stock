class ComputerProgram < ActiveRecord::Base
  attr_accessible :accountNotes, :description, :expDate, :installNotes, :license, :licenseCount, :name, :publisher, :serial, :status, :testingNotes, :uaAccountNo, :userID, :vendor, :classroomImage, :econImage, :labImage
  validates_presence_of :description, :name, :publisher, :serial

  def digest
  	"#{self.name} - #{self.serial}"
  end

  def status_alias
    if self.status==1 then
      "Active"
    elsif self.status==2 then
      "Archived"
    elsif self.status==3 then
      "Other"
    end
  end

  def self.to_csv(options = {})
    CSV.generate do |csv|
      csv << column_names
      all.each do |p|
        csv << p.attributes.values_at(*column_names)
      end
    end
  end

end
