class NewsItem < ActiveRecord::Base
	attr_accessible :newsText, :actionItemID, :title, :blogged
end
