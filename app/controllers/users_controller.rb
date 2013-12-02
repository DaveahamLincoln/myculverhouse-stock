class UsersController < ApplicationController
  
  #Comment to access the /users/new page as an anonymous user
  before_filter :check_your_privilege

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def edit_permissions
    @user = User.find(params[:id])
  end
  
  def create
    #I have no idea what this business about strong parameters is.
    #Adding the bang to permit makes user creation possible, otherwise you run into
    #the following error on the server:
    #
    #Processing by UsersController#create as HTML
    #    Parameters: {"utf8"=>"✓", "authenticity_token"=>"9iBY9NOqEXrupeWCwhsyjLH9PE7BggCFWhmtAWHHd4o=", 
    # "user"=>{"email"=>"steve", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "commit"=>"Create User"}
    #Unpermitted parameters: utf8, authenticity_token, user, commit
    #   (0.1ms)  BEGIN
      #   (0.0ms)  ROLLBACK
      #   Rendered users/new.html.erb within layouts/application (3.1ms)
    # Completed 200 OK in 13ms (Views: 9.5ms | ActiveRecord: 0.1ms)

    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        if @user.isFacultyUser
          @userFacultyUser = FacultyUser.new
          @userFacultyUser.update_attributes(:userID => @user.id, :facultyProfileID => @user.id)
          #@userFacultyProfile = FacultyProfile.new
          #@userFacultyProfile.update_attributes(:id => @user.id, :permalink => "#{@user.lastName}_#{@user.firstName}")

          @facultySite = Cms_Site.new do |u|
            u.label = "#{@user.firstName} #{@user.lastName}"
            u.path = "/faculty/#{@user.lastName}_#{@user.firstName}"
          end

          redirect_to root_url, :notice => "User has been added successfully."
        else
          redirect_to root_url, :notice => "User has been added successfully."
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.isFacultyUser
      @userFacultyUser = FacultyUser.where(userID: @user.id).first
      @userFacultyProfile = FacultyProfile.find(@userFacultyUser.facultyProfileID)

      @userFacultyProfile.destroy
      @userFacultyUser.destroy
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def check_your_privilege
    if current_user.nil? 
      redirect_to(root_url)
    else
      unless current_user.godBit or current_user.isSuperUser
        redirect_to(root_url)
      end
    end
      
  end

end