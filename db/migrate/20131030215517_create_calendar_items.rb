class CreateCalendarItems < ActiveRecord::Migration
  def change
    create_table :calendar_items do |t|
      t.integer :actionItemID
      t.text :calendarText
      t.date :calendarDate

      t.timestamps
    end
  end
end
