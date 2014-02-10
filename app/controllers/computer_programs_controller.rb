class ComputerProgramsController < ApplicationController
  # GET /programs
  # GET /programs.json
  def index
    @programs = ComputerProgram.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programs }
    end
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
    @program = ComputerProgram.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/new
  # GET /programs/new.json
  def new
    @program = ComputerProgram.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @program }
    end
  end

  # GET /programs/1/edit
  def edit
    @program = ComputerProgram.find(params[:id])
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = ComputerProgram.new(params[:computer_program])

    respond_to do |format|
      if @program.save
        format.html { redirect_to @program, notice: 'Program was successfully created.' }
        format.json { render json: @program, status: :created, location: @program }
      else
        format.html { render action: "new" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /programs/1
  # PUT /programs/1.json
  def update
    @program = ComputerProgram.find(params[:id])

    respond_to do |format|
      if @program.update_attributes(params[:program])
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
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
    @program = ComputerProgram.find(params[:id])
    @program.destroy

    respond_to do |format|
      format.html { redirect_to computer_programs_url }
      format.json { head :no_content }
    end
  end

  private

  def computer_program_params
      params.require(:computer_program).permit(:accountNotes, :description, :expDate, :installNotes, :license, :licenseCount, :name, :publisher, :serial, :status, :testingNotes, :uaAccountNo, :userID, :vendor)
  end
end
