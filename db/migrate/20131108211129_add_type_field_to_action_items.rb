class AddTypeFieldToActionItems < ActiveRecord::Migration
  def change
  	add_column :action_items,:type,:string
  end
end
