require 'test_helper'

class TroubleTicketsControllerTest < ActionController::TestCase
  setup do
    @trouble_ticket = trouble_tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trouble_tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trouble_ticket" do
    assert_difference('TroubleTicket.count') do
      post :create, trouble_ticket: { assignedTech: @trouble_ticket.assignedTech, assignedTechConfirmed: @trouble_ticket.assignedTechConfirmed, clientID: @trouble_ticket.clientID, dateClosed: @trouble_ticket.dateClosed, dateScheduled: @trouble_ticket.dateScheduled, equipmentID: @trouble_ticket.equipmentID, locationID: @trouble_ticket.locationID, problemDescription: @trouble_ticket.problemDescription, programID: @trouble_ticket.programID, receivingTech: @trouble_ticket.receivingTech, requestedBy: @trouble_ticket.requestedBy, resolution: @trouble_ticket.resolution, status: @trouble_ticket.status, supervisorID: @trouble_ticket.supervisorID, techNotes: @trouble_ticket.techNotes, urgency: @trouble_ticket.urgency }
    end

    assert_redirected_to trouble_ticket_path(assigns(:trouble_ticket))
  end

  test "should show trouble_ticket" do
    get :show, id: @trouble_ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trouble_ticket
    assert_response :success
  end

  test "should update trouble_ticket" do
    put :update, id: @trouble_ticket, trouble_ticket: { assignedTech: @trouble_ticket.assignedTech, assignedTechConfirmed: @trouble_ticket.assignedTechConfirmed, clientID: @trouble_ticket.clientID, dateClosed: @trouble_ticket.dateClosed, dateScheduled: @trouble_ticket.dateScheduled, equipmentID: @trouble_ticket.equipmentID, locationID: @trouble_ticket.locationID, problemDescription: @trouble_ticket.problemDescription, programID: @trouble_ticket.programID, receivingTech: @trouble_ticket.receivingTech, requestedBy: @trouble_ticket.requestedBy, resolution: @trouble_ticket.resolution, status: @trouble_ticket.status, supervisorID: @trouble_ticket.supervisorID, techNotes: @trouble_ticket.techNotes, urgency: @trouble_ticket.urgency }
    assert_redirected_to trouble_ticket_path(assigns(:trouble_ticket))
  end

  test "should destroy trouble_ticket" do
    assert_difference('TroubleTicket.count', -1) do
      delete :destroy, id: @trouble_ticket
    end

    assert_redirected_to trouble_tickets_path
  end
end
