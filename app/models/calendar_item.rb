class CalendarItem < ActiveRecord::Base
	attr_accessible :actionItemID, :calendarText, :calendarDate, :title
end
