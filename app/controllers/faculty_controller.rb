class FacultyController < ApplicationController

	#GET /faculty
	def index
	#Renders a list of Faculty users at /faculty
	#This allows faculty-manged CMS pages to propagate properly from /faculty/:id, while preserving the
	#ability to see a faculty index.  

	#Might be a good place to display profile pictures, if they are implemented at a later date.
		@faculty = User.where(isFacultyUser: 1)
		@faculty = @faculty.sort_by &:lastName
	end
end
