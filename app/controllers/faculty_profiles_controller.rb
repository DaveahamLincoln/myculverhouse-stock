class FacultyProfilesController < ApplicationController
  before_filter :set_faculty_profile, only: [:edit, :update, :destroy]
  before_filter :check_your_privilege

  # GET /faculty_profiles
  def index
    @faculty_profiles = FacultyProfile.all
  end

  # GET /faculty_profiles/1
  def show
    if params[:permalink]
      @faculty_profile = FacultyProfile.where(permalink: (params[:permalink])).first
      raise ActiveRecord::RecordNotFound, "Page not found" if @faculty_profile.nil?

      @faculty_name = User.find(@faculty_profile.id).formal_name
      @faculty_user = FacultyUser.find_by_facultyProfileID(@faculty_profile.id)
      @publications = Publication.where(:facultyUserID == @faculty_user.id)

    else
      @faculty_profile = FacultyProfile.find(params[:id])
      @faculty_name = User.find(@faculty_profile.id).formal_name
    end
  end

  # GET /faculty_profiles/new
  def new
    @faculty_profile = FacultyProfile.new
  end

  # GET /faculty_profiles/1/edit
  def edit
    @faculty_profile = FacultyProfile.find(params[:id])
    @faculty_name = User.find(@faculty_profile.id).formal_name
  end

  # POST /faculty_profiles
  def create
    @faculty_profile = FacultyProfile.new(faculty_profile_params)

    if @faculty_profile.save
      redirect_to @faculty_profile, notice: 'Faculty profile was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /faculty_profiles/1
  def update
    if @faculty_profile.update_attributes(faculty_profile_params)
      redirect_to @faculty_profile, notice: 'Faculty profile was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /faculty_profiles/1
  def destroy
    @faculty_profile.destroy
    redirect_to faculty_profiles_url, notice: 'Faculty profile was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faculty_profile
      @faculty_profile = FacultyProfile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def faculty_profile_params
      params.require(:faculty_profile).permit(:currentResearch, :education, :honors, :bodyText)
    end
    
    def check_your_privilege
      if current_user.nil? 
        redirect_to(root_url)
      else
        unless current_user.godBit or current_user.isSuperUser or current_user.isFacultyUser
          redirect_to(root_url)
        end
      end
    end

end
