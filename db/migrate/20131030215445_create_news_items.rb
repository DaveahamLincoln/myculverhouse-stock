class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.integer :actionItemID
      t.text :newsText
      t.date :newsDate

      t.timestamps
    end
  end
end
