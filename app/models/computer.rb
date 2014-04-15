class Computer < Equipment
	has_many :printer_associations

	def digest
	#Returns an easy to read name for a given computer.  Just call Equipment.digest to access it.
	#The digest format varies based on the type of equipment.
		"#{self.description} - SN#{self.serial}"
	end
end

