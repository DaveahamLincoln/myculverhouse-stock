require 'test_helper'

class UserPicturesControllerTest < ActionController::TestCase
  setup do
    @user_picture = user_pictures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_pictures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_picture" do
    assert_difference('UserPicture.count') do
      post :create, user_picture: { picturePath: @user_picture.picturePath, userID: @user_picture.userID }
    end

    assert_redirected_to user_picture_path(assigns(:user_picture))
  end

  test "should show user_picture" do
    get :show, id: @user_picture
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_picture
    assert_response :success
  end

  test "should update user_picture" do
    put :update, id: @user_picture, user_picture: { picturePath: @user_picture.picturePath, userID: @user_picture.userID }
    assert_redirected_to user_picture_path(assigns(:user_picture))
  end

  test "should destroy user_picture" do
    assert_difference('UserPicture.count', -1) do
      delete :destroy, id: @user_picture
    end

    assert_redirected_to user_pictures_path
  end
end
