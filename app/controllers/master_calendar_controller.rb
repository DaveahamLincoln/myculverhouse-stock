class MasterCalendarController < ApplicationController

	def index
		@calendar_items = CalendarItem.all
		#@action_items = ActionItem.where(:itemType == "calendar")
		@date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
		#@date = params[:month] ? Date.parse(params[:month]) : Date.today
	end

end