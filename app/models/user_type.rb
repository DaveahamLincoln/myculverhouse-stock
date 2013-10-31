class UserType < ActiveRecord::Base
  attr_accessible :isFacultyUser, :isGenericUSer, :isSuperUser, :userID
end
