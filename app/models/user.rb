class User < ActiveRecord::Base
	#Automatically checks to see if :password is present, so we don't need to validate it below.
	has_secure_password

	#Sets the required fields for creating a new User object.
	#:phone
	
	validates_presence_of :firstName, :lastName, :email, :password, :on => :create
	attr_accessible :email, :password, :lastName, :firstName, :isGenericUser, :isFacultyUser, :phoneNumber

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def formal_name
		"#{lastName}, #{firstName}"
	end

end

