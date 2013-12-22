class ActionItem < ActiveRecord::Base
  attr_accessible :createdByID, :isApproved, :itemType
end
