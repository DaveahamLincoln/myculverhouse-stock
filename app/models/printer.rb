class Printer < Equipment
	#Ensures that all printers have an IP.  The important thing to note here is that while :ip is NOT 
	#a required attribute for Equipment, we can make it required for certain subclasses.
	#This affords us greater control over the kinds of equipment we can put in and the requirements for
	#each type.
	validates_presence_of :ip
	
	has_many :printer_associations

	def digest
	#Returns an easy to read name for a given computer.  Just call Equipment.digest to access it.
	#The digest format varies based on the type of equipment.
		"#{self.description} - #{self.ip}"
	end
end