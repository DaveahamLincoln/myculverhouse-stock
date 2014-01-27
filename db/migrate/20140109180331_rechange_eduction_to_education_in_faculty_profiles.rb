class RechangeEductionToEducationInFacultyProfiles < ActiveRecord::Migration
    def up
		rename_column :faculty_profiles, :eduction, :education
	end
end
