class RemoveNewsDateFronNewsItems < ActiveRecord::Migration
  def up
  	remove_column :news_items, :newsDate
  end

  def down
  end
end
