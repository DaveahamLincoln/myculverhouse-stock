require 'test_helper'

class FacultyProfilesControllerTest < ActionController::TestCase
  setup do
    @faculty_profile = faculty_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:faculty_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create faculty_profile" do
    assert_difference('FacultyProfile.count') do
      post :create, faculty_profile: { currentResearch: @faculty_profile.currentResearch, eduction: @faculty_profile.eduction, honors: @faculty_profile.honors }
    end

    assert_redirected_to faculty_profile_path(assigns(:faculty_profile))
  end

  test "should show faculty_profile" do
    get :show, id: @faculty_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @faculty_profile
    assert_response :success
  end

  test "should update faculty_profile" do
    patch :update, id: @faculty_profile, faculty_profile: { currentResearch: @faculty_profile.currentResearch, eduction: @faculty_profile.eduction, honors: @faculty_profile.honors }
    assert_redirected_to faculty_profile_path(assigns(:faculty_profile))
  end

  test "should destroy faculty_profile" do
    assert_difference('FacultyProfile.count', -1) do
      delete :destroy, id: @faculty_profile
    end

    assert_redirected_to faculty_profiles_path
  end
end
