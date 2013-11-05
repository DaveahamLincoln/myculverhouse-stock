class FacultyProfile < ActiveRecord::Base
	attr_accessible :id, :permalink, :education, :currentResearch, :honors, :bodyText
end
