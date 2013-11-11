class NewsController < ApplicationController

	def index
		@news_items = NewsItem.all
		@action_items = ActionItem.where(:itemType == "calendar")
		#@date = params[:month] ? Date.parse(params[:month]) : Date.today
	end

end
