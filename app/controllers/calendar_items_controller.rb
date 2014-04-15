class CalendarItemsController < ApplicationController
  ##
  #Handles the CalendarItems submission process.  Approved users can submit CalendarItems, which are then sent to the ActionItems queue
  #to be approved by Admin/Communications users.
  #
  #    Use case:
  #    
  #    USER => CalendarItem.new => ActionItem.new 
  #    ADMIN => ActionItem.approve => CalendarItem shows up on MasterCalendar.index
  #
  ##

  #Loads the appropriate CalendarItem record for each page, based on the id passed in the params hash.
  before_filter :set_calendar_item, only: [:show, :edit, :update, :destroy]

  #Ensures that only authorized users will be able to access infacing CalendarItems controller methods.
  #Show is considered outfacing in this case because master_calendar redirects to the associated CalendarItem record when events are clicked.
  before_filter :check_your_privilege, only: [:index, :new, :edit, :create, :update, :destroy]

  # GET /calendar_items
  def index
    @calendar_items = CalendarItem.all
    @action_items = ActionItem.where(:itemType == "calendar")
  end

  # GET /calendar_items/1
  def show
  end

  # GET /calendar_items/new
  def new
    @calendar_item = CalendarItem.new
  end

  # GET /calendar_items/1/edit
  def edit
  end

  # POST /calendar_items
  def create
    @calendar_item = CalendarItem.new(calendar_item_params)

    #Creates an ActionItem in the ActionItems queue for the CalendarItem.
    @action_item = ActionItem.new
    @action_item.update_attributes(createdByID: current_user.id, isApproved: false, itemType: "calendar")

    #Associates the CalendarItem with the newly created ActionItem.
    @calendar_item.update_attributes(actionItemID: @action_item.id)

    if @calendar_item.save
      redirect_to @calendar_item, notice: 'Calendar item was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /calendar_items/1
  def update
    if @calendar_item.update_attributes(calendar_item_params)
      redirect_to @calendar_item, notice: 'Calendar item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /calendar_items/1
  def destroy
    #Retrieves and destroys the associated ActionItem.
    @calendarItemActionItem = ActionItem.where(id: @calendar_item.actionItemID).first
    @calendarItemActionItem.destroy
    
    @calendar_item.destroy
    redirect_to calendar_items_url, notice: 'Calendar item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar_item
      @calendar_item = CalendarItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def calendar_item_params
      params.require(:calendar_item).permit(:actionItemID, :calendarText, :calendarDate, :title)
    end

    def check_your_privilege
      if current_user.nil? 
        redirect_to(root_url)
      else
        unless current_user.godBit or current_user.isSuperUser or current_user.isFacultyUser or current_user.isCommunicationsUser
          redirect_to(root_url)
        end
      end
    end

end
