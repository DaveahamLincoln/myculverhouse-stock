class FacultyUser < ActiveRecord::Base
	attr_accessible :id, :userID, :facultyProfileID, :userPictureID, :cms_site_id

	def formal_name
		User.find(self.userID).formal_name
	end

end
