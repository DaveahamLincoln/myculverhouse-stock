class TroubleTicketsController < ApplicationController
  before_filter :set_trouble_ticket, only: [:show,:edit,:update,:destroy,:closed_tickets]

  # GET /trouble_tickets
  # GET /trouble_tickets.json
  def index
    @trouble_tickets = TroubleTicket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trouble_tickets }
    end
  end

  # GET /trouble_tickets/1
  # GET /trouble_tickets/1.json
  def show
    @trouble_ticket = TroubleTicket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trouble_ticket }
    end
  end

  # GET /trouble_tickets/new
  # GET /trouble_tickets/new.json
  def new
    @trouble_ticket = TroubleTicket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trouble_ticket }
    end
  end

  # GET /trouble_tickets/1/edit
  def edit
  end

  def close
    @trouble_ticket = TroubleTicket.find(params[:id])
    respond_to do |format|
      if @trouble_ticket.status == 0
        format.html { redirect_to @trouble_ticket, notice: 'Trouble ticket is already closed.' }
        format.json { head :no_content }
      else
        if current_user.godBit or current_user.isSupervisor or current_user.isTech
          #Begin pre-close completeness check.
          if (@trouble_ticket.resolution.empty? && @trouble_ticket.resolutionDescription.empty?)
            format.html { redirect_to @trouble_ticket, notice: 'Please enter a resolution and resolution description for this ticket.' }
            format.json { head :no_content }
          elsif @trouble_ticket.resolution.empty?
            format.html { redirect_to @trouble_ticket, notice: 'Please enter a resolution for this ticket.' }
            format.json { head :no_content }
          elsif @trouble_ticket.resolutionDescription.empty?
            format.html { redirect_to @trouble_ticket, notice: 'Please enter a resolution description for this ticket.' }
            format.json { head :no_content }
          #end
          else
            @trouble_ticket.update(:dateClosed => Time.now())
            @trouble_ticket.update(:closingTechID => current_user.id)
            @trouble_ticket.update(:status => 0)
            format.html { redirect_to @trouble_ticket, notice: 'Trouble ticket has been closed successfully.' }
            format.json { head :no_content }
            @trouble_ticket.send_trouble_ticket_close_burst
          end
        else
          format.html { redirect_to @trouble_ticket, notice: 'You do not have sufficient permissions to close tickets.' }
          format.json { head :no_content }
        end
      end
    end
  end

  def closed_tickets
  end

  # POST /trouble_tickets
  # POST /trouble_tickets.json
  def create
    @trouble_ticket = TroubleTicket.new(trouble_ticket_params)

    respond_to do |format|
      if @trouble_ticket.save
        format.html { redirect_to @trouble_ticket, notice: 'Trouble ticket was successfully created.' }
        format.json { render json: @trouble_ticket, status: :created, location: @trouble_ticket }
        @trouble_ticket.send_trouble_ticket_create_burst
      else
        format.html { render action: "new" }
        format.json { render json: @trouble_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trouble_tickets/1
  # PATCH/PUT /trouble_tickets/1.json
  def update
    @trouble_ticket = TroubleTicket.find(params[:id])

    respond_to do |format|
      if @trouble_ticket.update_attributes(trouble_ticket_params)
        format.html { redirect_to @trouble_ticket, notice: 'Trouble ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trouble_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trouble_tickets/1
  # DELETE /trouble_tickets/1.json
  def destroy
    @trouble_ticket = TroubleTicket.find(params[:id])
    @trouble_ticket.destroy

    respond_to do |format|
      format.html { redirect_to trouble_tickets_url }
      format.json { head :no_content }
    end
  end

  def accept_ticket
    respond_to do |format|
      @trouble_ticket=TroubleTicket.find(params[:id])
      @trouble_ticket.update(:assignedTechConfirmed => 1)
      format.html { redirect_to @trouble_ticket, notice: 'Trouble ticket has been accepted successfully.' }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def trouble_ticket_params
      params.require(:trouble_ticket).permit(:assignedTech, :assignedTechConfirmed, :clientID, :dateClosed, :dateScheduled, :equipmentID, :locationID, :problemDescription, :programID, :receivingTech, :requestedBy, :resolution, :status, :supervisorID, :techNotes, :urgency)
    end

    def set_trouble_ticket
      #Basically a throw/catch to pass an empty ticket to the controller if no ticket is passed to the controller otherwise.
      begin
        @trouble_ticket = TroubleTicket.find(params[:id])
      rescue 
        @trouble_ticket = TroubleTicket.new
      end
    end

end
