class CalendarItemsController < ApplicationController
  before_filter :set_calendar_item, only: [:show, :edit, :update, :destroy]

  # GET /calendar_items
  def index
    @calendar_items = CalendarItem.all
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

    if @calendar_item.save
      redirect_to @calendar_item, notice: 'Calendar item was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /calendar_items/1
  def update
    if @calendar_item.update(calendar_item_params)
      redirect_to @calendar_item, notice: 'Calendar item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /calendar_items/1
  def destroy
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
      params.require(:calendar_item).permit(:actionItemID, :calendarText, :calendarDate)
    end
end
