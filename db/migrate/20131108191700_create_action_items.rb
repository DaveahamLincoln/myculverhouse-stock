class CreateActionItems < ActiveRecord::Migration
  def change
    create_table :action_items do |t|
      t.integer :createdByID
      t.boolean :isApproved

      t.timestamps
    end
  end
end
