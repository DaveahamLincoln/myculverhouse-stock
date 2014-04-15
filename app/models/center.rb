class Center < ActiveRecord::Base
  attr_accessible :cms_site_id, :name

  #Defines the fields that are required.
  validates_presence_of :name
end
