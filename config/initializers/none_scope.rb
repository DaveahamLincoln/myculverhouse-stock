class ActiveRecord::Base
 #This allows you to call Model.none to return an empty AR relation for refactoring.
 def self.none
   where(arel_table[:id].eq(nil).and(arel_table[:id].not_eq(nil)))
 end
end