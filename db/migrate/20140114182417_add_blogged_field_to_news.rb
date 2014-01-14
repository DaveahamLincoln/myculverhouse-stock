class AddBloggedFieldToNews < ActiveRecord::Migration
  def change
  	add_column :news_items,:blogged,:boolean, :default => 0
  end

  def down
  	raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end

