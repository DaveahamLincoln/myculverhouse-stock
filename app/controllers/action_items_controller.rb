class ActionItemsController < ApplicationController
  ##
  #Handles the ActionItems queue, which allows approved users to screen events and news submitted by other users before it is
  #posted to outfacing pages.
  #
  #    Use case:
  #    
  #    ADMIN => ActionItem.approve => CalendarItem shows up on MasterCalendar.index
  #    ADMIN => ActionItem.approve => NewsItem shows up on News.index
  #
  ##


  #Ensures that only authorized users will be able to access the ActionItems controller methods.
  before_filter :check_your_privilege

  # GET /action_items
  # GET /action_items.json
  def index
    @action_items = ActionItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @action_items }
    end
  end

  # POST /action_items
  # POST /action_items.json
  def create
    @action_item = ActionItem.new(action_item_params)

    respond_to do |format|
      if @action_item.save
        format.html { redirect_to @action_item, notice: 'Action item was successfully created.' }
        format.json { render json: @action_item, status: :created, location: @action_item }
      else
        format.html { render action: "new" }
        format.json { render json: @action_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /action_items/1
  # PATCH/PUT /action_items/1.json
  def update
    @action_item = ActionItem.find(params[:id])

    respond_to do |format|
      if @action_item.update_attributes(action_item_params)
        format.html { redirect_to @action_item, notice: 'Action item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @action_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /action_items/1
  # DELETE /action_items/1.json
  def destroy
    @action_item = ActionItem.find(params[:id])
    
    #Determines the type of action item and enables it on the appropriate page.
    if @action_item.itemType == "news"
      @action_item_proper = NewsItem.where(actionItemID: @action_item.id).first
    elsif @action_item.itemType == "calendar"
      @action_item_proper = CalendarItem.where(actionItemID: @action_item.id).first
    end

    @action_item_proper.destroy
    @action_item.destroy

    respond_to do |format|
      format.html { redirect_to action_items_url }
      format.json { head :no_content }
    end
  end

  #Approval method.
  #Admins and communications users can approve action items.  Once approved, an action item will show up on the proper outfacing page.
  #Example- an approved CalendarItem will become visible on the Master_Calendar page.
  def approve
    respond_to do |format|
      @action_item=ActionItem.find(params[:id])
      if @action_item.isApproved
        @action_item.update_attributes(:isApproved => 0)
        format.html { redirect_to action: 'index', notice: 'Item has been unapproved successfully.' }
        format.json { head :no_content }
      else
        @action_item.update_attributes(:isApproved => 1)
        format.html { redirect_to action: 'index', notice: 'Item has been approved successfully.' }
        format.json { head :no_content }
      end
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def action_item_params
      params.require(:action_item).permit(:createdByID, :isApproved)
    end

    def check_your_privilege
      if current_user.nil? 
        redirect_to(root_url)
      else
        unless current_user.godBit or current_user.isSuperUser or current_user.isCommunicationsUser
          redirect_to(root_url)
        end
      end
    end
end
