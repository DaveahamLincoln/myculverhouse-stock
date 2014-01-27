class CentersController < ApplicationController

  #Comment to access the /centers/new page as an anonymous user
  before_filter :check_your_privilege, only: [:new, :create, :update, :destroy]

  # GET /centers
  # GET /centers.json
  def index
    @centers = Center.all
    @centers = @centers.sort_by &:name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @centers }
    end
  end

=begin
  This is disabled, because of the way I have the mnemonic routing set up.
  Essentially, if you leave it in, it catches the /centers/foo call and tries to route it to the show action of 
  a center with id 'foo'

  # GET /centers/1
  # GET /centers/1.json
  def show
    @center = Center.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @center }
    end
  end
=end

  # GET /centers/new
  # GET /centers/new.json
  def new
    @center = Center.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @center }
    end
  end

=begin
  This is disabled because centers are immutable- to change one you must delete it, delete its CMS site, and then create it afresh. 

  # GET /centers/1/edit
  def edit
    @center = Center.find(params[:id])
  end
=end

  # POST /centers
  # POST /centers.json
  def create
    @center = Center.new(center_params)

    respond_to do |format|
      if @center.save
          @centerSite = Cms::Site.new
          #Removes all url-unfriendly characters from the name to create an identifier Comfy can use.
          @ident = @center.name.gsub(/[^a-zA-Z 0-9]/, "")
          @ident = @ident.gsub(/\s/,'_')
          @centerSite.update_attributes(
            #binds center sites to easy-to-remember mnemonics.
            identifier: "#{@ident.downcase}",

            #pulls the hostname for the parent site
            hostname: '0.0.0.0:3000',

            #sets the root path for the new site to /centers.  There is no actual /centers route handled by Comfy, but it provides an easy mnemonic
            #GET "/centers" should be mapped to a static page that links to all sites created in this manner.
            path: "centers/#{@ident.downcase}"
            )
          @centerSite.save!
          @center.update_attributes(cms_site_id: @centerSite.id)
          format.html { redirect_to '/centers', notice: 'Center was successfully created.' }
          format.json { render json: @center, status: :created, location: @center }
      else
        format.html { render action: "new" }
        format.json { render json: @center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /centers/1
  # PATCH/PUT /centers/1.json
  def update
    @center = Center.find(params[:id])

    respond_to do |format|
      if @center.update_attributes(center_params)
        format.html { redirect_to @center, notice: 'Center was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /centers/1
  # DELETE /centers/1.json
  def destroy
    @center = Center.find(params[:id])
    @centerSite = Cms::Site.find(@center.id)
    #Uncomment to activate linked deletion functionality.  Per Freddie, we want to force users to go into the CMS and delete sites manually,
    #rather than binding the destroy to the control panel destroy action, but I figured I'd include this in case this changed.
    @center.destroy
    #@centerSite.destroy

    respond_to do |format|
      format.html { redirect_to centers_url }
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
    def center_params
      params.require(:center).permit(:cms_site_id, :name)
    end
end
