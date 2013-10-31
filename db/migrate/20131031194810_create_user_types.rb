class CreateUserTypes < ActiveRecord::Migration
  def change
    create_table :user_types do |t|
      t.integer :userID
      t.boolean :isSuperUser
      t.boolean :isGenericUSer
      t.boolean :isFacultyUser

      t.timestamps
    end
  end
end
