class ApplicationController < ActionController::Base
 
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

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

