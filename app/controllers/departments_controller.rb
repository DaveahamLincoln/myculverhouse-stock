class DepartmentsController < ApplicationController

  #Comment to access the /departments/new page as an anonymous user
  before_filter :check_your_privilege, only: [:new, :create, :update, :destroy, :edit]

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

  #This is odd because of the way I have the mnemonic routing set up.
  #    Essentially, if you leave this alone, it catches the /Departments/foo call and tries to route it to the show action of 
  #    a Department with id 'foo.'  Now it catches the call differently, so GET /departments/foo will go to the CMS page for foo
  #    and GET /departments/shard/:id will route to the department record for foo.

  # GET /departments/shard/1
  # GET /departments/shard/1.json
  def show
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @Department }
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

  # GET /departments/shard/1/edit
  #Note: Changing the name of a department will not change their site slug, this has to be done manually right now,
  #    I'm not sure if there's a way to avoid having to do this.
  def edit
    @department = Department.find(params[:id])
  end


  # POST /departments
  # POST /departments.json
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

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department = Department.find(params[:id])
    #Bad logic below.
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
      params.require(:department).permit(:cms_site_id, :poBox, :building, :fax, :office, :phone, :name)
    end
end
