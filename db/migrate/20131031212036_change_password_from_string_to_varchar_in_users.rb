class ChangePasswordFromStringToVarcharInUsers < ActiveRecord::Migration
  def up
  	change_column :users, :password, :varchar
  end

  def down
  end
end
