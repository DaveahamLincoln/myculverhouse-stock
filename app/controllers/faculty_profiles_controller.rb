class FacultyProfilesController < ApplicationController
  before_filter :set_faculty_profile, only: [:show, :edit, :update, :destroy]

  # GET /faculty_profiles
  def index
    @faculty_profiles = FacultyProfile.all
  end

  # GET /faculty_profiles/1
  def show
  end

  # GET /faculty_profiles/new
  def new
    @faculty_profile = FacultyProfile.new
  end

  # GET /faculty_profiles/1/edit
  def edit
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
    if @faculty_profile.update(faculty_profile_params)
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
      params.require(:faculty_profile).permit(:currentResearch, :eduction, :honors)
    end
end
