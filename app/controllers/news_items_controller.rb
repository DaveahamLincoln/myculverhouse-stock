class NewsItemsController < ApplicationController
  before_filter :set_news_item, only: [:show, :edit, :update, :destroy]
  before_filter :check_your_privilege

  # GET /news_items
  def index
    @news_items = NewsItem.all
  end

  # GET /news_items/1
  def show
  end

  # GET /news_items/new
  def new
    @news_item = NewsItem.new
    @action_item = ActionItem.new
    @action_item.update_attributes(:createdByID => current_user.id, :isApproved => false, :itemType => "news")
  end

  # GET /news_items/1/edit
  def edit
  end

  # POST /news_items
  def create
    @news_item = NewsItem.new(news_item_params)

    if @news_item.save
      redirect_to @news_item, notice: 'News item was successfully created.'
    else
      render action: 'new'
    end  
  end

  # PATCH/PUT /news_items/1
  def update
    if @news_item.update(news_item_params)
      redirect_to @news_item, notice: 'News item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /news_items/1
  def destroy
    @newsItemActionItem = ActionItem.where(id: @news_item.actionItemID).first
    @newsItemActionItem.destroy
    @news_item.destroy

    redirect_to news_items_url, notice: 'News item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_item
      @news_item = NewsItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def news_item_params
      params.require(:news_item).permit(:actionItemID, :newsText, :newsDate)
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
