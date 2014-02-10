class PrinterAssociationsController < ApplicationController
  # GET /printer_associations
  # GET /printer_associations.json
  def index
    @printer_associations = PrinterAssociation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @printer_associations }
    end
  end

  # GET /printer_associations/1
  # GET /printer_associations/1.json
  def show
    @printer_association = PrinterAssociation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @printer_association }
    end
  end

  # GET /printer_associations/new
  # GET /printer_associations/new.json
  def new
    @printer_association = PrinterAssociation.new
    @equipmentID = params[:equipmentID]
    @printer_association.update_attributes(equipmentID: @equipmentID)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @printer_association }
    end
  end

  # GET /printer_associations/1/edit
  #def edit
  #  @printer_association = PrinterAssociation.find(params[:id])
  #end

  # POST /printer_associations
  # POST /printer_associations.json
  def create
    @printer_association = PrinterAssociation.new(params[:printer_association])

    respond_to do |format|
      if @printer_association.save
        format.html { redirect_to @printer_association, notice: 'Printer association was successfully created.' }
        format.json { render json: @printer_association, status: :created, location: @printer_association }
      else
        format.html { render action: "new" }
        format.json { render json: @printer_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /printer_associations/1
  # PUT /printer_associations/1.json
  def update
    @printer_association = PrinterAssociation.find(params[:id])

    respond_to do |format|
      if @printer_association.update_attributes(params[:printer_association])
        format.html { redirect_to @printer_association, notice: 'Printer association was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @printer_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /printer_associations/1
  # DELETE /printer_associations/1.json
  def destroy
    @printer_association = PrinterAssociation.find(params[:id])
    @printer_association.destroy

    respond_to do |format|
      format.html { redirect_to printer_associations_url }
      format.json { head :no_content }
    end
  end
end
