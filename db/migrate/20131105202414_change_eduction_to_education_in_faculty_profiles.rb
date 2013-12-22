class ChangeEductionToEducationInFacultyProfiles < ActiveRecord::Migration
  def up
  	rename_column :faculty_profiles, :eduction, :education
  end

  def down
  end
end
