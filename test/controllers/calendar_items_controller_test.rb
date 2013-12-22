require 'test_helper'

class CalendarItemsControllerTest < ActionController::TestCase
  setup do
    @calendar_item = calendar_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calendar_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calendar_item" do
    assert_difference('CalendarItem.count') do
      post :create, calendar_item: { actionItemID: @calendar_item.actionItemID, calendarDate: @calendar_item.calendarDate, calendarText: @calendar_item.calendarText }
    end

    assert_redirected_to calendar_item_path(assigns(:calendar_item))
  end

  test "should show calendar_item" do
    get :show, id: @calendar_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calendar_item
    assert_response :success
  end

  test "should update calendar_item" do
    patch :update, id: @calendar_item, calendar_item: { actionItemID: @calendar_item.actionItemID, calendarDate: @calendar_item.calendarDate, calendarText: @calendar_item.calendarText }
    assert_redirected_to calendar_item_path(assigns(:calendar_item))
  end

  test "should destroy calendar_item" do
    assert_difference('CalendarItem.count', -1) do
      delete :destroy, id: @calendar_item
    end

    assert_redirected_to calendar_items_path
  end
end
