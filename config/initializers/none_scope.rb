class ActiveRecord::Base
 #This allows you to call Model.none to return an empty ActiveRecord relation for refactoring.
 #VERY USEFUL.  You might never need it, but PLEASE LEAVE IT ALONE.
 def self.none
   where(arel_table[:id].eq(nil).and(arel_table[:id].not_eq(nil)))
 end
end