class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # POST /jobs/:ticketID
  def new
    @job = Job.new
    @ticketID = params[:ticketID]
    @job.update_attributes(ticketID: @ticketID)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  #def edit
  #  @job = Job.find(params[:id])
  #end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def complete
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.completed
        format.html { redirect_to "/trouble_tickets/#{params(:id)}", notice: 'Job is already complete.' }
        format.json { head :no_content }
      else
        if current_user.godBit or current_user.isSupervisorUser or current_user.isTechUser
          @job.update_attributes(:completed => true)
          @job.update_attributes(:completedByID => current_user.id)
          format.html { redirect_to "/trouble_tickets/#{@job.ticketID}", notice: 'Job completed.' }
        else
          format.html { redirect_to @trouble_ticket, notice: 'You do not have sufficient permissions to close jobs.' }
          format.json { head :no_content }
        end
      end
    end
  end

  def reopen
    @job = Job.find(params[:id])
    respond_to do |format|
      if !@job.completed
        format.html { redirect_to trouble_ticket_path(:ticketID), notice: 'Job is already open.' }
        format.json { head :no_content }
      else
        if current_user.godBit or current_user.isSupervisorUser or current_user.isTechUser
          @job.update_attributes(:completed => false)
          @job.update_attributes(:completedByID => nil)
          format.html { redirect_to "/trouble_tickets/#{@job.ticketID}", notice: 'Job reopened.' }
        else
          format.html { redirect_to @trouble_ticket, notice: 'You do not have sufficient permissions to reopen jobs.' }
          format.json { head :no_content }
        end
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def job_params
      params.require(:job).permit(:completed, :completedByID, :description, :ticketID)
    end
end
