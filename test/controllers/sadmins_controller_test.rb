require 'test_helper'

class SadminsControllerTest < ActionController::TestCase
  setup do
    @sadmin = sadmins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sadmins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sadmin" do
    assert_difference('Sadmin.count') do
      post :create, sadmin: { username: @sadmin.username }
    end

    assert_redirected_to sadmin_path(assigns(:sadmin))
  end

  test "should show sadmin" do
    get :show, id: @sadmin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sadmin
    assert_response :success
  end

  test "should update sadmin" do
    patch :update, id: @sadmin, sadmin: { username: @sadmin.username }
    assert_redirected_to sadmin_path(assigns(:sadmin))
  end

  test "should destroy sadmin" do
    assert_difference('Sadmin.count', -1) do
      delete :destroy, id: @sadmin
    end

    assert_redirected_to sadmins_path
  end
end
