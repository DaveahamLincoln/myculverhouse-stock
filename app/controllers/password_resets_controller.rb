class PasswordResetsController < ApplicationController

	def new
	end

	def create
  		user = User.find_by_email(params[:email])
  		user.send_password_reset if user
  		redirect_to root_url, :notice => "Email sent with password reset instructions."
	end

	def edit
  		@user = User.find_by_password_reset_token!(params[:id])
	end

	def update
  		@user = User.find_by_password_reset_token!(params[:id])
  		if @user.password_reset_sent_at < 2.hours.ago
    		redirect_to new_password_reset_path, :alert => "Password reset has expired."

      #Having to use the .permit! force so much worries me.  I don't really understand why there's so much protection against 
      #modifying attributes, but it might be something we need to look into solving more elegantly in the future.
  		elsif @user.update_attributes(params[:user])
    		redirect_to root_url, :notice => "Password has been reset!"
  		else
    		render :edit
    	end
  	end
end


