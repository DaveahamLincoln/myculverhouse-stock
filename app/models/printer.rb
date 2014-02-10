class Printer < Equipment
	validates_presence_of :ip
	has_many :printer_associations

	def digest
		"#{self.description} - #{self.ip}"
	end
end