class FacultyUser < ActiveRecord::Base
	attr_accessible :id, :userID, :facultyProfileID, :userPictureID
end
