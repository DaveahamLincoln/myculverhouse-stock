require 'test_helper'

class DepartmentAdminActionsControllerTest < ActionController::TestCase
  test "should get updateFacultyProfile" do
    get :updateFacultyProfile
    assert_response :success
  end

  test "should get updateUserPicture" do
    get :updateUserPicture
    assert_response :success
  end

  test "should get updatePublication" do
    get :updatePublication
    assert_response :success
  end

  test "should get addUser" do
    get :addUser
    assert_response :success
  end

  test "should get submitProfileForDeletion" do
    get :submitProfileForDeletion
    assert_response :success
  end

  test "should get createFacultyUser" do
    get :createFacultyUser
    assert_response :success
  end

end
