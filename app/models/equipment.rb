class Equipment < ActiveRecord::Base
  #Single Table Inheritance Types
  # => Computer
  # => Printer
  # => Other
  #
  #To add a new type, rails g a model, eg. "Foo"
  #Edit foo.rb to inherit from Equipment,
  #   class Foo < Equipment
  #Add the type to preload_sti_models.rb in the initializers folder

	belongs_to :department
	belongs_to :location
	has_many :tickets
  
  #This allows us to manage task creation much more easily.  For a better explanation of how this is done, 
  #check out
  #http://railscasts.com/episodes/17-habtm-checkboxes
  has_and_belongs_to_many :tasks

	attr_accessible :status, :locationID, :departmentID, :serial, :description, :ip, :type
	
  #Defines the fields that are required.
  validates_presence_of :status, :locationID, :departmentID, :serial, :description, :type

  def digest
    #Returns an easy to read name for a given computer.  Just call Equipment.digest to access it.
    #The digest format varies based on the type of equipment.
    #This particular method is a catch-all in case a new STI type is added and you forget to include a digest 
    #method in the model for that type, or if you're fine with the format outlined below.
    "#{self.description} - SN#{self.serial}"
  end

	def self.select_options
		#Automatically populates the type selector on the _form page with any new subclasses we add.
		#make sure if you add a subclass that you add it to the preloader in 
    #/config/initializers/preload_sti_models.rb
		descendants.map {|c| c.to_s}.sort
	end

	def self.inherited(child)
		#All we’re doing here is overriding the model_name method for subclasses of Equipment so ActionPack will 
    #see them as belonging to the parent class (Equipment), and thus use the parent class’s named routes 
    #(EquipmentController) wherever URLs are generated.
		child.instance_eval do
  	  def model_name
    	  Equipment.model_name
  		end
		end
		super
  end

  def statusAlias
    #Returns a string representation of a given status for rendering in a view.  You can add more status types
    #by defining them here.
    case self.status
    when 1
      "Normal"
    when 2
      "Inactive"
    when 3
      "Awaiting Service"
    when 4
      "Surplus"
    when 5
      "On Order"
    else
      "Error"
    end
  end
end

