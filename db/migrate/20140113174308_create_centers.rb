class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.string :name
      t.integer :cms_site_id

      t.timestamps
    end
  end
end
