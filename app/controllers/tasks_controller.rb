class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  def closed_tickets
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @equipment = @task.equipment

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    @lab_ticket = LabTicket.find(params[:labTicketID])
    @lab_equipment = Equipment.where(locationID: @lab_ticket.locationID)
    @task.update_attributes(labTicketID: @lab_ticket.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @lab_equipment = Equipment.where(locationID: LabTicket.find(@task.labTicketID).id)

  end

  def close
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.completed
        format.html { redirect_to @task, notice: 'Task is already complete.' }
        format.json { head :no_content }
      else
        if current_user.godBit or current_user.isSupervisor or current_user.isTech
          @task.update_attributes(completed: true)
          @task.update_attributes(dateClosed: Time.now())
          @task.update_attributes(closingTech: current_user.id)
          format.html { redirect_to @task, notice: 'Task has been completed successfully.' }
          format.json { head :no_content }
          #@task.send_task_close_burst
        else
          format.html { redirect_to @task, notice: 'You do not have sufficient permissions to close tickets.' }
          format.json { head :no_content }
        end
      end
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    params[:task][:equipment_ids] ||= []
    @task = Task.find(params[:id])
    @task.equipment_ids = params[:task][:equipment_ids]

    respond_to do |format|
      if @task.update_attributes(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def task_params
      params.require(:task).permit(:assignedTech, :completed, :description, :labTicketID, :completed)
    end
end
