class User < ActiveRecord::Base
	#Automatically checks to see if :password is present, so we don't need to validate it below.
	has_secure_password
	
	#For Paperclip
	#has_attached_file :avatar, :styles => { :medium =>"300x300>", :thumb => "100x100>", :default_url => "/images/:style/missing.png" }

	#Sets the required fields for creating a new User object.
	validates_presence_of :firstName, :lastName, :email, :password, :password_confirmation, :on => :create
	attr_accessible :email, :password, :password_confirmation, :lastName, :firstName, 
      :isGenericUser, :isFacultyUser, :isSuperUser, :isCommunicationsUser, :phoneNumber,:isSupervisorUser,
      :isTechUser,:isClientUser,:departmentID,:locationID #:phone, :avatar

	def send_password_reset
		#Handles password-reset functionality using the password_reset mailer.
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def generate_token(column)
		#Builds secret tokens for password resets.
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def formal_name
		#Returns a string for easily rendering user names in views.
		"#{lastName}, #{firstName}"
	end

end

