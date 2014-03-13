class LabTicketsController < ApplicationController
  # GET /lab_tickets
  # GET /lab_tickets.json
  def index
    @lab_tickets = LabTicket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lab_tickets }
    end
  end

  # GET /lab_tickets/1
  # GET /lab_tickets/1.json
  def show
    @lab_ticket = LabTicket.find(params[:id])
    @tasks = Task.where(labTicketID: @lab_ticket.id)
    @lab_equipment = Equipment.where(locationID: @lab_ticket.locationID)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lab_ticket }
    end
  end

  # GET /lab_tickets/new
  # GET /lab_tickets/new.json
  def new
    @lab_ticket = LabTicket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lab_ticket }
    end
  end

  #GET "lab_tickets/:id/new_task" => "lab_tickets#new_task"
  def new_task
    @lab_ticket = LabTicket.find(params[:id])
    @task = Task.new
    @task.update_attributes(labTicketID: @lab_ticket.id)
  end

  # GET /lab_tickets/1/edit
  def edit
    @lab_ticket = LabTicket.find(params[:id])
  end

  def close
    @lab_ticket = LabTicket.find(params[:id])
    respond_to do |format|
      if @lab_ticket.complete
        format.html { redirect_to @lab_ticket, notice: 'Lab ticket is already closed.' }
        format.json { head :no_content }
      else
        if current_user.godBit or current_user.isSupervisor or current_user.isTech
          #Begin pre-close completeness check.
          if @lab_ticket.resolution.empty?
            format.html { redirect_to @lab_ticket, notice: 'Please enter a resolution for this ticket.' }
            format.json { head :no_content }
          else
            @lab_ticket.update_attributes(:dateClosed => Time.now())
            @lab_ticket.update_attributes(:closingTech => current_user.id)
            @lab_ticket.update_attributes(:status => 0)
            format.html { redirect_to @lab_ticket, notice: 'Lab ticket has been closed successfully.' }
            format.json { head :no_content }
            @lab_ticket.send_lab_ticket_close_burst
          end
        else
          format.html { redirect_to @lab_ticket, notice: 'You do not have sufficient permissions to close tickets.' }
          format.json { head :no_content }
        end
      end
    end
  end

  # POST /lab_tickets
  # POST /lab_tickets.json
  def create
    @lab_ticket = LabTicket.new(lab_ticket_params)

    respond_to do |format|
      if @lab_ticket.save
        format.html { redirect_to @lab_ticket, notice: 'Lab ticket was successfully created.' }
        format.json { render json: @lab_ticket, status: :created, location: @lab_ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @lab_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_task
    @task = Task.create!(params[:task])
    flash[:notice] = "Task added."
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /lab_tickets/1
  # PATCH/PUT /lab_tickets/1.json
  def update
    @lab_ticket = LabTicket.find(params[:id])

    respond_to do |format|
      if @lab_ticket.update_attributes(lab_ticket_params)
        format.html { redirect_to @lab_ticket, notice: 'Lab ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lab_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lab_tickets/1
  # DELETE /lab_tickets/1.json
  def destroy
    @lab_ticket = LabTicket.find(params[:id])
    @lab_ticket.destroy

    respond_to do |format|
      format.html { redirect_to lab_tickets_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def lab_ticket_params
      params.require(:lab_ticket).permit(:clientID, :dateScheduled, :locationID, :problemDescription, :programID, :receivingTech, :requestedBy, :resolution, :status, :supervisorID, :techNotes, :urgency)
    end
end
