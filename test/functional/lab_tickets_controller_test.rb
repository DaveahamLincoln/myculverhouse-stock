require 'test_helper'

class LabTicketsControllerTest < ActionController::TestCase
  setup do
    @lab_ticket = lab_tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lab_tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lab_ticket" do
    assert_difference('LabTicket.count') do
      post :create, lab_ticket: { clientID: @lab_ticket.clientID, dateScheduled: @lab_ticket.dateScheduled, locationID: @lab_ticket.locationID, problemDescription: @lab_ticket.problemDescription, programID: @lab_ticket.programID, receivingTech: @lab_ticket.receivingTech, requestedBy: @lab_ticket.requestedBy, resolution: @lab_ticket.resolution, status: @lab_ticket.status, supervisorID: @lab_ticket.supervisorID, techNotes: @lab_ticket.techNotes, urgency: @lab_ticket.urgency }
    end

    assert_redirected_to lab_ticket_path(assigns(:lab_ticket))
  end

  test "should show lab_ticket" do
    get :show, id: @lab_ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lab_ticket
    assert_response :success
  end

  test "should update lab_ticket" do
    put :update, id: @lab_ticket, lab_ticket: { clientID: @lab_ticket.clientID, dateScheduled: @lab_ticket.dateScheduled, locationID: @lab_ticket.locationID, problemDescription: @lab_ticket.problemDescription, programID: @lab_ticket.programID, receivingTech: @lab_ticket.receivingTech, requestedBy: @lab_ticket.requestedBy, resolution: @lab_ticket.resolution, status: @lab_ticket.status, supervisorID: @lab_ticket.supervisorID, techNotes: @lab_ticket.techNotes, urgency: @lab_ticket.urgency }
    assert_redirected_to lab_ticket_path(assigns(:lab_ticket))
  end

  test "should destroy lab_ticket" do
    assert_difference('LabTicket.count', -1) do
      delete :destroy, id: @lab_ticket
    end

    assert_redirected_to lab_tickets_path
  end
end
