class RenameTypeFieldToItemType < ActiveRecord::Migration
  def up
  	rename_column :action_items, :type, :itemType
  end

  def down
  end
end
