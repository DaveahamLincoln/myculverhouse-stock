class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.integer :facultyUserID
      t.text :publicationText
      t.string :phoneNumber

      t.timestamps
    end
  end
end
