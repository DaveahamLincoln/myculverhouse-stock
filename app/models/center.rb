class Center < ActiveRecord::Base
  attr_accessible :cms_site_id, :name
  validates_presence_of :name
end
