class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
  	remove_column :Users, :password, :varchar
  	add_column :Users, :password_digest, :string
  end
end
