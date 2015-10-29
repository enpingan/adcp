require 'test_helper'

class DevicesControllerTest < ActionController::TestCase
  setup do
    @device = devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:devices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device" do
    assert_difference('Device.count') do
      post :create, device: { addons: @device.addons, device_note: @device.device_note, device_type: @device.device_type, general_reloaded: @device.general_reloaded, general_status: @device.general_status, location: @device.location, name: @device.name, osname: @device.osname, osprocessor: @device.osprocessor, osram: @device.osram, private_ip: @device.private_ip, public_ip: @device.public_ip }
    end

    assert_redirected_to device_path(assigns(:device))
  end

  test "should show device" do
    get :show, id: @device
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device
    assert_response :success
  end

  test "should update device" do
    patch :update, id: @device, device: { addons: @device.addons, device_note: @device.device_note, device_type: @device.device_type, general_reloaded: @device.general_reloaded, general_status: @device.general_status, location: @device.location, name: @device.name, osname: @device.osname, osprocessor: @device.osprocessor, osram: @device.osram, private_ip: @device.private_ip, public_ip: @device.public_ip }
    assert_redirected_to device_path(assigns(:device))
  end

  test "should destroy device" do
    assert_difference('Device.count', -1) do
      delete :destroy, id: @device
    end

    assert_redirected_to devices_path
  end
end
