class Department < ActiveRecord::Base
  has_many :equipment
  validates_presence_of :building, :fax, :office, :phone, :name
  attr_accessible :building, :fax, :name, :office, :phone, :poBox, :cms_site_id
end
