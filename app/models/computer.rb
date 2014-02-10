class Computer < Equipment
	has_many :printer_associations

	def digest
		"#{self.description} - #{self.serial}"
	end
end

