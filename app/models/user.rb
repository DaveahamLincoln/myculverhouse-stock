class User < ActiveRecord::Base
	#Automatically checks to see if :password is present, so we don't need to validate it below.
	has_secure_password
	acts_as_commontator


	#For Paperclip
	#has_attached_file :avatar, :styles => { :medium =>"300x300>", :thumb => "100x100>", :default_url => "/images/:style/missing.png" }

	#Sets the required fields for creating a new User object.
	#:phone
	
	validates_presence_of :firstName, :lastName, :email, :password, :password_confirmation, :on => :create
	attr_accessible :email, :password, :password_confirmation, :lastName, :firstName, 
      :isGenericUser, :isFacultyUser, :isSuperUser, :isCommunicationsUser, :phoneNumber,:isSupervisorUser,
      :isTechUser,:isClientUser,:departmentID,:locationID
	#:avatar

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

