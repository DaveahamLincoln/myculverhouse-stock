class UsersController < ApplicationController
  
  #Comment to access the /users/new page as an anonymous user
  #before_filter :verify_is_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
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
    if @user.save
      @userType = UserType.new
      @userType.update_attributes(:userID => @user.id)
      redirect_to root_url, :notice => "User has been added successfully."
    else
      render "new"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def verify_is_admin
    if current_user.nil? 
      redirect_to(root_url)
    else
      unless current_user.godBit
      redirect_to(root_url)
    end
      
  end

end
end


=begin
  before_filter :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :godBit, :firstName, :lastName)
    end
end
=end

