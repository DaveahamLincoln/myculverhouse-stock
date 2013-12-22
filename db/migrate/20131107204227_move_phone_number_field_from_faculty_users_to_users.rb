class MovePhoneNumberFieldFromFacultyUsersToUsers < ActiveRecord::Migration
  def up
  	remove_column :faculty_users, :phoneNumber
  	add_column :users,:phoneNumber,:string
  end

  def down
  end
end
