class Computer < Equipment
	has_many :printer_associations

	def digest
		"#{self.description} - SN#{self.serial}"
	end
end

