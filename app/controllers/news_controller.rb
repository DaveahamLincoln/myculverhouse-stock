class NewsController < ApplicationController

	before_filter :check_your_privilege

	def index
		@news_items = NewsItem.all
		@action_items = ActionItem.where(:itemType == "calendar")
		#@date = params[:month] ? Date.parse(params[:month]) : Date.today
	end

	def mark_as_blogged
		@news_item = NewsItem.find(params[:id])
		@news_item.update_attributes(
			blogged: 1
			)
		redirect_to(:back)
	end

	private

	def check_your_privilege
      if current_user.nil? 
        redirect_to(root_url)
      else
        unless current_user.godBit or current_user.isSuperUser or current_user.isCommunicationsUser
          redirect_to(root_url)
        end
      end
    end

end
