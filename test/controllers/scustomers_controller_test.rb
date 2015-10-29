require 'test_helper'

class ScustomersControllerTest < ActionController::TestCase
  setup do
    @scustomer = scustomers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scustomers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scustomer" do
    assert_difference('Scustomer.count') do
      post :create, scustomer: { username: @scustomer.username }
    end

    assert_redirected_to scustomer_path(assigns(:scustomer))
  end

  test "should show scustomer" do
    get :show, id: @scustomer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scustomer
    assert_response :success
  end

  test "should update scustomer" do
    patch :update, id: @scustomer, scustomer: { username: @scustomer.username }
    assert_redirected_to scustomer_path(assigns(:scustomer))
  end

  test "should destroy scustomer" do
    assert_difference('Scustomer.count', -1) do
      delete :destroy, id: @scustomer
    end

    assert_redirected_to scustomers_path
  end
end
