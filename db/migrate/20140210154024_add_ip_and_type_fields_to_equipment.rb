class AddIpAndTypeFieldsToEquipment < ActiveRecord::Migration
  def change
  	add_column :equipment, :ip, :string
  	add_column :equipment, :type, :string
  end
end
