class DepartmentsController < ApplicationController

  #Comment to access the /Departments/new page as an anonymous user
  before_filter :check_your_privilege, only: [:new, :create, :update, :destroy]

  # GET /Departments
  # GET /Departments.json
  def index
    @departments = Department.all
    @departments = @departments.sort_by &:name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @Departments }
    end
  end

=begin
  This is disabled, because of the way I have the mnemonic routing set up.
  Essentially, if you leave it in, it catches the /Departments/foo call and tries to route it to the show action of 
  a Department with id 'foo'

  # GET /Departments/1
  # GET /Departments/1.json
  def show
    @Department = Department.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @Department }
    end
  end
=end

  # GET /Departments/new
  # GET /Departments/new.json
  def new
    @department = Department.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @department }
    end
  end

=begin
  This is disabled because Departments are immutable- to change one you must delete it, delete its CMS site, and then create it afresh. 

  # GET /Departments/1/edit
  def edit
    @Department = Department.find(params[:id])
  end
=end

  # POST /Departments
  # POST /Departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
          @departmentSite = Cms::Site.new
          #Removes all url-unfriendly characters from the name to create an identifier Comfy can use.
          @ident = @department.name.gsub(/[^a-zA-Z 0-9]/, "")
          @ident = @ident.gsub(/\s/,'_')
          @departmentSite.update_attributes(
            #binds Department sites to easy-to-remember mnemonics.
            identifier: "#{@ident.downcase}",

            #pulls the hostname for the parent site
            hostname: '0.0.0.0:3000',

            #sets the root path for the new site to /Departments.  There is no actual /Departments route handled by Comfy, but it provides an easy mnemonic
            #GET "/departments" should be mapped to a static page that links to all sites created in this manner.
            path: "departments/#{@ident.downcase}"
            )
          @departmentSite.save!
          @department.update_attributes(cms_site_id: @departmentSite.id)
          format.html { redirect_to "/departments", notice: 'Department was successfully created.' }
          format.json { render json: @department, status: :created, location: @department }
      else
        format.html { render action: "new" }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Departments/1
  # PATCH/PUT /Departments/1.json
  def update
    @department = Department.find(params[:id])

    respond_to do |format|
      if @department.update_attributes(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Departments/1
  # DELETE /Departments/1.json
  def destroy
    @department = Department.find(params[:id])
    @departmentSite = Cms::Site.find(@department.id)
    #Uncomment to activate linked deletion functionality.  Per Freddie, we want to force users to go into the CMS and delete sites manually,
    #rather than binding the destroy to the control panel destroy action, but I figured I'd include this in case this changed.
    @department.destroy
    #@departmentSite.destroy

    respond_to do |format|
      format.html { redirect_to departments_url }
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

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def department_params
      params.require(:department).permit(:cms_site_id, :name)
    end
end
