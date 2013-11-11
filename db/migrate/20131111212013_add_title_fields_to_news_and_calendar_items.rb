class AddTitleFieldsToNewsAndCalendarItems < ActiveRecord::Migration
  def change
  	add_column :news_items,:title,:string
  	add_column :calendar_items,:title,:string
  end
end
