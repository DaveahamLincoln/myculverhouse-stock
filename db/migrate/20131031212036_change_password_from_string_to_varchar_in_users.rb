class ChangePasswordFromStringToVarcharInUsers < ActiveRecord::Migration
  def up
  	change_column :Users, :password, :varchar
  end

  def down
  end
end
