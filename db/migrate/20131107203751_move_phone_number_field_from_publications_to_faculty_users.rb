class MovePhoneNumberFieldFromPublicationsToFacultyUsers < ActiveRecord::Migration
  def up
  	remove_column :publications, :phoneNumber
  	add_column :faculty_users,:phoneNumber,:string
  end

  def down
  end
end
