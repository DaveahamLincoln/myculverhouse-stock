class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :password, :varchar
  	add_column :users, :password_digest, :string
  end
end
