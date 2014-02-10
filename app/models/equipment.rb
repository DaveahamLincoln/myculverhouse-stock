class Equipment < ActiveRecord::Base
	belongs_to :department
	belongs_to :location
	has_many :tickets
  	attr_accessible :status, :locationID, :departmentID, :serial, :description, :ip, :type
  	validates_presence_of :status, :locationID, :departmentID, :serial, :description, :type

  	def self.select_options
  		#Automatically populates the type selector on the _form page with any new subclasses we add.
  		#make sure if you add a subclass that you add it to the preloader in /config/initializers/preload_sti_models.rb
  		descendants.map {|c| c.to_s}.sort
  	end

  	def self.inherited(child)
  		#All we’re doing here is overriding the model_name method for subclasses of Equipment so ActionPack will see them
  		#as belonging to the parent class (Equipment), and thus use the parent class’s named routes (EquipmentController) 
  		#wherever URLs are generated.
  		child.instance_eval do
    	    def model_name
      			Equipment.model_name
    		end
  		end
  		super
	  end

    def digest
      "#{self.description} - #{self.serial}"
    end

    def statusAlias
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

