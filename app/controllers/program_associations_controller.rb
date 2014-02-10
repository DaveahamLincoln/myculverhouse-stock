class ProgramAssociationsController < ApplicationController
  # GET /program_associations
  # GET /program_associations.json
  def index
    @program_associations = ProgramAssociation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @program_associations }
    end
  end

  # GET /program_associations/1
  # GET /program_associations/1.json
  def show
    @program_association = ProgramAssociation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @program_association }
    end
  end

  # GET /program_associations/new
  # GET /program_associations/new.json
  def new
    @program_association = ProgramAssociation.new
    @equipmentID = params[:equipmentID]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @program_association }
    end
  end

  # GET /program_associations/1/edit
  #def edit
  #  @program_association = ProgramAssociation.find(params[:id])
  #end

  # POST /program_associations
  # POST /program_associations.json
  def create
    @program_association = ProgramAssociation.new(params[:program_association])

    respond_to do |format|
      if @program_association.save
        format.html { redirect_to @program_association, notice: 'Program association was successfully created.' }
        format.json { render json: @program_association, status: :created, location: @program_association }
      else
        format.html { render action: "new" }
        format.json { render json: @program_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /program_associations/1
  # PUT /program_associations/1.json
  def update
    @program_association = ProgramAssociation.find(params[:id])

    respond_to do |format|
      if @program_association.update_attributes(params[:program_association])
        format.html { redirect_to @program_association, notice: 'Program association was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @program_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_associations/1
  # DELETE /program_associations/1.json
  def destroy
    @program_association = ProgramAssociation.find(params[:id])
    @program_association.destroy

    respond_to do |format|
      format.html { redirect_to program_associations_url }
      format.json { head :no_content }
    end
  end
end
