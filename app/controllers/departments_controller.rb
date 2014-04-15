class DepartmentsController < ApplicationController
  ##
  #Handles the Departments creation process.  First, Departments are created and loaded into the Departments index, then a CMS site is
  #automatically generated to be edited at a later date.
  #
  #    Use case:
  #    
  #    USER => Department.new => Cms::Site.new
  #    USER => /cms_admin => Edit Department site.
  #
  ##

  #Ensures that only authorized users will be able to access the infacing Departments controller methods.
  before_filter :check_your_privilege, only: [:new, :create, :destroy, :edit]

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all
    @departments = @departments.sort_by &:name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @Departments }
    end
  end

  # GET /departments/new
  # GET /departments/new.json
  def new
    @department = Department.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @department }
    end
  end

=begin
  This is disabled because centers are immutable- to change one you must delete it, delete its CMS site, and then create it afresh. 
  #GET /departments/shard/1/edit
  def edit
    @department = Department.find(params[:id])
  end
=end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save

          #Creates a new CMS site linked to the newly created Department record.
          @departmentSite = Cms::Site.new
        
          #Removes all url-unfriendly characters from the name to create an identifier Comfy can use.
          @ident = @department.name.gsub(/[^a-zA-Z 0-9]/, "")
        
          #Replaces spaces in the Department name with underscores.
          @ident = @ident.gsub(/\s/,'_')
        
          @departmentSite.update_attributes(
            #Binds Department sites to easy-to-remember mnemonics.
            identifier: "#{@ident.downcase}",

            #Pulls the hostname for the parent site
            #TODO PREDEPLOY: Change this hostname to the deployment hostname.
            hostname: '0.0.0.0:3000',

            #Sets the root path for the new site to /Departments.  There is no actual /Departments route handled by Comfy, but it provides an easy mnemonic
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

=begin
  Disabled for the same reason as edit.

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
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
=end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department = Department.find(params[:id])
    @departmentSite = Cms::Site.find(@department.id)
    @department.destroy
    
    #Uncomment to activate linked deletion functionality.  Per Freddie, we want to force users to go into the CMS and delete sites manually,
    #rather than binding the destroy to the control panel destroy action, but I figured I'd include this in case this changed.
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
      params.require(:department).permit(:cms_site_id, :poBox, :building, :fax, :office, :phone, :name)
    end
end
