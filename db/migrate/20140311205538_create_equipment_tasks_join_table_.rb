=begin
has_and_belongs_to_many(name, scope = nil, options = {}, &extension) public

Specifies a many-to-many relationship with another class. This associates two classes via an intermediate 
join table. Unless the join table is explicitly specified as an option, it is guessed using the lexical order 
of the class names. So a join between Developer and Project will give the default join table name of 
“developers_projects” because “D” precedes “P” alphabetically. Note that this precedence is calculated using the 
< operator for String. This means that if the strings are of different lengths, and the strings are equal when 
compared up to the shortest length, then the longer string is considered of higher lexical precedence than the 
shorter one. For example, one would expect the tables “paper_boxes” and “papers” to generate a join table name of
"papers_paper_boxes” because of the length of the name “paper_boxes”, but it in fact generates a join table name
of “paper_boxes_papers”. Be aware of this caveat, and use the custom :join_table option if you need to. If your 
tables share a common prefix, it will only appear once at the beginning. For example, the tables 
“catalog_categories” and “catalog_products” generate a join table name of “catalog_categories_products”.
The join table should not have a primary key or a model associated with it. You must manually generate the join 
table with a migration such as this:
	
=end

class CreateEquipmentTasksJoinTable < ActiveRecord::Migration
  def change
  	create_table :equipment_tasks, id: false do |t|
  		t.integer :equipment_id
  		t.integer :task_id
  	end
  end

  def down
  end
end
