class EquipmentController < ApplicationController

  # GET /equipment
  # GET /equipment.json
  def index
    @equipment = Equipment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @equipment }
    end
  end

  # GET /equipment/1
  # GET /equipment/1.json
  def show
    @equipment = Equipment.find(params[:id])

    #Stock rqrcode QR implementation
    #Creates a QR code which points to the url of the Equipment record
    #!TODO Alter predeploy
    @qr = RQRCode::QRCode.new("http://0.0.0.0:3000/equipment/#{@equipment.id}")
    @tickets = TroubleTicket.where(equipmentID: @equipment.id)

    #Disables the ticket display until tickets are working.
    #@tickets = Equipment.none

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @equipment }
      
      #rqrcode-rails3 QR implementation
      #format.gif {render (qrcode: "http://0.0.0.0:3000/equipment/#{@equipment.id}", offset: 5, unit: 11 }
    end
  end

  def label
    #Takes the user to a page where the QR label can be printed easily.

    @equipment = Equipment.find(params[:id])

    #Stock rqrcode QR implementation
    #!TODO Alter predeploy
    @qr = RQRCode::QRCode.new("http://0.0.0.0:3000/equipment/#{@equipment.id}")

    render :layout => false

  end


  # GET /equipment/new
  # GET /equipment/new.json
  def new
    @equipment = Equipment.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @equipment }
    end
  end

  # GET /equipment/1/edit
  def edit
    @equipment = Equipment.find(params[:id])
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = (params[:equipment][:type]).classify.constantize.new(params[:equipment])
    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: 'Equipment was successfully created.' }
        format.json { render json: @equipment, status: :created, location: @equipment }
      else
        format.html { render action: "new" }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /equipment/1
  # PUT /equipment/1.json
  def update
    @equipment = Equipment.find(params[:id])

    respond_to do |format|
      if @equipment.update_attributes(params[:equipment])
        format.html { redirect_to @equipment, notice: 'Equipment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy

    respond_to do |format|
      format.html { redirect_to equipment_index_url }
      format.json { head :no_content }
    end
  end
end
