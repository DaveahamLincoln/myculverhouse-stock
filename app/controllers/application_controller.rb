class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  def comment 
    # Extracts the name of the class
    klass = self.class.to_s[/\A(\w+)sController\Z/,1] 
    # Evaluates the class and gets the current object of that class
    @comentable_class = eval "#{klass}.find(params[:id])"
    # Creates a comment using the data of the form
    comment = Comment.new(params[:comment])
    # Adds the comment to that instance of the class
    @comentable_class.add_comment(comment)

    flash[:notice] = "Your comment has been added!"
    redirect_to :action => "show", :id => params[:id] 
  end    

  private

  def current_user
  	#Uncomment if a user gets "stuck" in a migrated session.  An error along the lines of 
  	#RecordNotFound in IndexController#index, Couldn't find User with id=n will show up.  Will handle more gracefully in the future, 
  	#but for now this works just fine.  Just get the user to the homepage, then have them logout.  This should purge the ActiveRecord.
  	
  	#@current_user = User.new

  	#Comment when unsticking a stuck migration.
  	@current_user ||= User.find(session[:user_id]) if session[:user_id] 
  	
  end

  helper_method :current_user
end

