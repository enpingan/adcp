require 'test_helper'

class PcustomersControllerTest < ActionController::TestCase
  setup do
    @pcustomer = pcustomers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pcustomers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pcustomer" do
    assert_difference('Pcustomer.count') do
      post :create, pcustomer: { username: @pcustomer.username }
    end

    assert_redirected_to pcustomer_path(assigns(:pcustomer))
  end

  test "should show pcustomer" do
    get :show, id: @pcustomer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pcustomer
    assert_response :success
  end

  test "should update pcustomer" do
    patch :update, id: @pcustomer, pcustomer: { username: @pcustomer.username }
    assert_redirected_to pcustomer_path(assigns(:pcustomer))
  end

  test "should destroy pcustomer" do
    assert_difference('Pcustomer.count', -1) do
      delete :destroy, id: @pcustomer
    end

    assert_redirected_to pcustomers_path
  end
end
