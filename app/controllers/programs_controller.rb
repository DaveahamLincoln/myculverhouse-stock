class ProgramsController < ApplicationController

  #Comment to access the /programs/new page as an anonymous user
  before_filter :check_your_privilege, only: [:new, :create, :update, :destroy]

  # GET /programs
  # GET /programs.json
  def index
    @programs = Program.all
    @programs = @programs.sort_by &:name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programs }
    end
  end

=begin
  This is disabled, because of the way I have the mnemonic routing set up.
  Essentially, if you leave it in, it catches the /programs/foo call and tries to route it to the show action of 
  a program with id 'foo'

  # GET /programs/1
  # GET /programs/1.json
  def show
    @program = program.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @program }
    end
  end
=end

  # GET /programs/new
  # GET /programs/new.json
  def new
    @program = Program.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @program }
    end
  end

=begin
  This is disabled because programs are immutable- to change one you must delete it, delete its CMS site, and then create it afresh. 

  # GET /programs/1/edit
  def edit
    @program = program.find(params[:id])
  end
=end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.new(program_params)

    respond_to do |format|
      if @program.save
          @programSite = Cms::Site.new
          #Removes all url-unfriendly characters from the name to create an identifier Comfy can use.
          @ident = @program.name.gsub(/[^a-zA-Z 0-9]/, "")
          @ident = @ident.gsub(/\s/,'_')
          @programSite.update_attributes(
            #binds program sites to easy-to-remember mnemonics.
            identifier: "#{@ident}",

            #pulls the hostname for the parent site
            hostname: 'localhost:3000',

            #sets the root path for the new site to /programs.  There is no actual /programs route handled by Comfy, but it provides an easy mnemonic
            #GET "/programs" should be mapped to a static page that links to all sites created in this manner.
            path: "programs/#{@ident}"
            )
          @programSite.save!
          @program.update_attributes(cms_site_id: @programSite.id)
          format.html { redirect_to @program, notice: 'program was successfully created.' }
          format.json { render json: @program, status: :created, location: @program }
      else
        format.html { render action: "new" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1
  # PATCH/PUT /programs/1.json
  def update
    @program = Program.find(params[:id])

    respond_to do |format|
      if @program.update_attributes(program_params)
        format.html { redirect_to @program, notice: 'program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program = Program.find(params[:id])
    @programSite = Cms::Site.find(@program.id)
    #Uncomment to activate linked deletion functionality.  Per Freddie, we want to force users to go into the CMS and delete sites manually,
    #rather than binding the destroy to the control panel destroy action, but I figured I'd include this in case this changed.
    #@program.destroy
    #@programSite.destroy

    respond_to do |format|
      format.html { redirect_to programs_url }
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
    def program_params
      params.require(:program).permit(:cms_site_id, :name)
    end
end