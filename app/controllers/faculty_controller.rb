class FacultyController < ApplicationController
	def index
		@faculty = User.where(isFacultyUser: 1)
		@faculty = @faculty.sort_by &:lastName
	end
end
