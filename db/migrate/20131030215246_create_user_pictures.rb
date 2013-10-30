class CreateUserPictures < ActiveRecord::Migration
  def change
    create_table :user_pictures do |t|
      t.integer :userID
      t.string :picturePath

      t.timestamps
    end
  end
end
