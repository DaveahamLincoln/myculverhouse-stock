class ComputerProgramsController < ApplicationController
  ##
  #Provides access to the ComputerPrograms model.
  #
  ##

  # GET /computer_programs
  # GET /computer_programs.json
  # GET /computer_programs.csv
  def index
    @programs = ComputerProgram.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @programs }
      #Exports the list of all ComputerPrograms to a .csv file.
      format.csv { send_data @programs.to_csv}
    end
  end

  #GET /computer_programs/classroom
  #GET /computer_programs/classroom.csv
  def classroom
    #Lists the ComputerPrograms currently installed on the Classrom Image.
    @programs = ComputerProgram.where(classroomImage: true) 

    respond_to do |format|   
      format.html
      #Exports the image listing to a .csv file.
      format.csv { send_data ComputerProgram.to_csv(@programs)}
    end
  end

  #GET /computer_programs/econ
  #GET /computer_programs/econ.csv
  def econ
    #Lists the ComputerPrograms currently installed on the Econ Image.
    @programs = ComputerProgram.where(econImage: true) 
    respond_to do |format|   
      format.html
      #Exports the image listing to a .csv file.
      format.csv { send_data ComputerProgram.to_csv(@programs)}
    end
  end

  #GET /computer_programs/lab
  #GET /computer_programs/lab.csv
  def lab
    #Lists the ComputerPrograms currently installed on the Lab Image.
    @programs = ComputerProgram.where(labImage: true)
    respond_to do |format|   
      format.html
      #Exports the image listing to a .csv file.
      format.csv { send_data ComputerProgram.to_csv(@programs)}
    end
  end

  #GET /computer_programs/archived
  #GET /computer_programs/archived.csv
  def archived
    #Lists the ComputerPrograms not currently installed on an image.
    @programs = ComputerProgram.where(classroomImage: false, econImage:false, labImage: false)
    respond_to do |format|   
      format.html
      #Exports the image listing to a .csv file.
      format.csv { send_data ComputerProgram.to_csv(@programs)}
    end
  end

  # GET /computer_programs/1
  # GET /computer_programs/1.json
  def show
    @program = ComputerProgram.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @program }
    end
  end

  # GET /computer_programs/new
  # GET /computer_programs/new.json
  def new
    @program = ComputerProgram.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @program }
    end
  end

  # GET /computer_programs/1/edit
  def edit
    @program = ComputerProgram.find(params[:id])
  end

  # POST /computer_programs
  # POST /computer_programs.json
  def create
    @program = ComputerProgram.new(params[:computer_program])

    if @program.save
        redirect_to @program, notice: 'Program was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /computer_programs/1
  # PUT /computer_programs/1.json
  def update
    @program = ComputerProgram.find(params[:id])

    respond_to do |format|
      if @program.update_attributes(params[:computer_program])
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /computer_programs/1
  # DELETE /computer_programs/1.json
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
      params.require(:computer_program).permit(:accountNotes, :description, :expDate, :installNotes, 
          :license, :licenseCount, :name, :publisher, :serial, :status, :testingNotes, :uaAccountNo, 
          :userID, :vendor, :classroomImage, :econImage, :labImage)
      params.require(:attachments_attributes).permit(:description,:file)

  end
end
