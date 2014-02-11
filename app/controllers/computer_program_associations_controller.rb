class ComputerProgramAssociationsController < ApplicationController
  # GET /computer_program_associations
  # GET /computer_program_associations.json
  def index
    @computer_program_associations = ComputerProgramAssociation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @computer_program_associations }
    end
  end

  # GET /computer_program_associations/1
  # GET /computer_program_associations/1.json
  def show
    @computer_program_association = ComputerProgramAssociation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @computer_program_association }
    end
  end

  # GET /computer_program_associations/new
  # GET /computer_program_associations/new.json
  def new
    @computer_program_association = ComputerProgramAssociation.new
    @equipmentID = params[:equipmentID]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @computer_program_association }
    end
  end

  # GET /computer_program_associations/1/edit
  #def edit
  #  @computer_program_association = ProgramAssociation.find(params[:id])
  #end

  # POST /computer_program_associations
  # POST /computer_program_associations.json
  def create
    @computer_program_association = ComputerProgramAssociation.new(params[:computer_program_association])

    respond_to do |format|
      if @computer_program_association.save
        format.html { redirect_to @computer_program_association, notice: 'Program association was successfully created.' }
        format.json { render json: @computer_program_association, status: :created, location: @computer_program_association }
      else
        format.html { render action: "new" }
        format.json { render json: @computer_program_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /computer_program_associations/1
  # PUT /computer_program_associations/1.json
  def update
    @computer_program_association = ComputerProgramAssociation.find(params[:id])

    respond_to do |format|
      if @computer_program_association.update_attributes(params[:computer_program_association])
        format.html { redirect_to @computer_program_association, notice: 'Program association was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @computer_program_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /computer_program_associations/1
  # DELETE /computer_program_associations/1.json
  def destroy
    @computer_program_association = ComputerProgramAssociation.find(params[:id])
    @computer_program_association.destroy

    respond_to do |format|
      format.html { redirect_to computer_program_associations_url }
      format.json { head :no_content }
    end
  end

  #POST /computer_program_associations/uninstall/1
  def uninstall
    @equipment = Equipment.find(params[:equipmentID])
  end
end
