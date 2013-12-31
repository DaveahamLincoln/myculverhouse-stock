class RecreateFacultyProfiles < ActiveRecord::Migration
  def change
    create_table :faculty_profiles do |t|
      t.text :currentResearch
      t.text :eduction
      t.text :honors

      t.timestamps
    end
  end
end
