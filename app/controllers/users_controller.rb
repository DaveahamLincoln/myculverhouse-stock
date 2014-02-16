class UsersController < ApplicationController
  
require'socket'

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
          @userFacultyUser.update_attributes(userID: @user.id, facultyProfileID: @user.id, userPictureID: @user.id)
          
          #Alright, this works by creating a FacultyProfile object which can be manipulated through the FacultyProfiles Controller
          #Provides micro-cms functionality for use as a stopgap if I can't get Comfy working alongside myCulverhouse
          #
          @userFacultyProfile = FacultyProfile.new
          @userFacultyProfile.update_attributes(id: @user.id, permalink: "/faculty/#{@user.lastName}_#{@user.firstName}")
          
          #According to Oleg at Comfy, I can use this to create a new Comfy-site for each faculty user.
          #
          @userFacultySite = Cms::Site.new
          @userFacultySite.update_attributes(
            #binds faculty sites to easy-to-remember mnemonics.
            identifier: "#{@user.lastName.downcase}_#{@user.firstName.downcase}",

            #pulls the hostname for the parent site
            hostname: 'rubywebdev.cba.ua.edu:3000',

            #sets the root path for the new site to /faculty.  There is no actual /faculty route handled by Comfy, but it provides an easy mnemonic
            #GET "/faculty" should be mapped to a static page that links to all sites created in this manner.
            #something like Cms::Site.all.each do |site|
            #    if site.path == '/faculty'
            #    '''show a link to the site'''

            path: "faculty/#{@user.lastName.downcase}_#{@user.firstName.downcase}"
            )
          @userFacultySite.save!
          @userFacultyUser.update_attributes(cms_site_id: @userFacultySite.id)
          format.html { redirect_to @user, notice: "User has been added successfully." }

        elsif @user.isSuperUser or @user.isCommunicationsUser
          #Kicker to add admins and comm users to the Monologue user group.
          Monologue::User.create(
            name: @user.formal_name,
            email: @user.email,
            password: @user.password,
            password_confirmation: @user.password_confirmation
            )

=begin
          #might need this at a later date
          #it's a self-managed cms, not an engine cms.
          @userFacultyPage = cms_sites(@userFacultySite.id)
          @userFacultyPage.update_attributes(
            :slug => 'profile'
            :layout => cms_layouts(:default)
            )
          @userFacultyPage.save!
=end

          format.html { redirect_to @user, notice: "User has been added successfully." }
        else
          format.html { redirect_to @user, notice: "User has been added successfully." }
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

  def show
    @user = User.find(params[:id])
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
