require 'test_helper'

class VerifiedsControllerTest < ActionController::TestCase
  setup do
    @verified = verifieds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:verifieds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create verified" do
    assert_difference('Verified.count') do
      post :create, verified: { email: @verified.email, password: @verified.password, username: @verified.username }
    end

    assert_redirected_to verified_path(assigns(:verified))
  end

  test "should show verified" do
    get :show, id: @verified
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @verified
    assert_response :success
  end

  test "should update verified" do
    patch :update, id: @verified, verified: { email: @verified.email, password: @verified.password, username: @verified.username }
    assert_redirected_to verified_path(assigns(:verified))
  end

  test "should destroy verified" do
    assert_difference('Verified.count', -1) do
      delete :destroy, id: @verified
    end

    assert_redirected_to verifieds_path
  end
end
