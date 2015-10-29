require 'will_paginate/array'
 
class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index

    if current_user.username == "CyberAdvance" || current_user.is_cdevice || current_user.is_mdevice || current_user.is_rdevice
      @devices = Device.all
      um = ""
    else
      @devices = Device.where(:owner=>current_user.username)
      um = current_user.username
    end
    # fresh_when @devices

    # paginate
    if params[:device_rows].nil?
      @rows = 5
    else 
      @rows = params[:device_rows]
    end

    if params[:page].nil?
      @page_number = 1
    else
      @page_number = params[:page]
    end

    @filter_word = params[:search]
    @filter_item = params[:filter_item]

    # sort
    @thd = []
    
    if !params[:sort_item].nil?
      did = Device.to_thdindex(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    # delete device ajax
    if !params[:device_id].nil?
      Device.delete_device(params[:device_id])
    end

    if !params[:sort_item].nil?
      str_order = Device.device_sortable(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @devices = Device.search(@filter_word, @filter_item).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    else
      @devices = Device.search(@filter_word, @filter_item).order(str_order).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    end
    fresh_when @devices

    flash[:filter_str] = ""
    @dnotes = Dnote.order(:is_checked=>:desc).order(:updated_at=>:desc)
  end

  def configure
    if current_user.username == "CyberAdvance" || current_user.is_cdevice || current_user.is_mdevice || current_user.is_rdevice
      @devices = Device.all
      um = ""
    else
      @devices = Device.where(:owner=>current_user.username)
      um = current_user.username
    end
    fresh_when @devices
    # paginate
    if params[:configure_rows].nil?
      @rows = 5
    else 
      @rows = params[:configure_rows]
    end

    if params[:page].nil?
      @page_number = 1
    else
      @page_number = params[:page]
    end

    @filter_word = params[:search]
    # sort
    @thd = []
    
    if !params[:sort_item].nil?
      did = Device.to_thdindex2(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    if !params[:sort_item].nil?
      str_order = Device.configure_sortable(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @devices = Device.search(@filter_word, @filter_item).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    else
      @devices = Device.search(@filter_word, @filter_item).order(str_order).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    end    

    @devices = @devices.paginate(:page => params[:page], :per_page => @rows.to_i)
    fresh_when @devices
    # saction
    if !params[:dnote_id].nil?
      if !params[:delete_log].nil?
        Device.delete_log(params)
      else
        Device.saction(params)
      end
    end

    @dnotes = Dnote.order(:is_checked=>:desc).order(:updated_at=>:desc)
    fresh_when @dnotes
  end

  def add_user
    du = DeviceUser.new(:username=>params[:username], :password=>params[:password], :device_name=>params[:device_name])
    du.save

    redirect_to devices_url
  end

  def delete_log
    did = params[:dnote_id]

    dn = Dnote.find_by_id(did)
    if !dn.nil?
      dn.delete
    end

    render json:nil, status: :ok
  end

  def quick_edit

    if params[:action] == "quick_edit"
      tc = Device.find_by_id(params[:id])

      if !params[:devicename].nil? 
        tc.name = params[:devicename]
        adnotes = Dnote.where(:device_name=>params[:devicename])
        fresh_when adnotes

        if !adnotes.blank?
          adnotes.each do |a|
            a.device_name = params[:devicename]
            a.save
          end
        end

        adusers = DeviceUser.where(:device_name=>params[:devicename])
        fresh_when adusers

        if !adusers.blank?
          adusers.each do |a|
            a.device_name = params[:devicename]
            a.save
          end
        end

        tc.public_ip = params[:publicip]
        tc.private_ip = params[:privateip]
        tc.save
      end

      if !params[:note].nil? 
        tc.device_note = params[:note]
        tc.addons = params[:addons]
        tc.save
      end

    end

    render json:nil, status: :ok
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
    @customers = Customer.order(:updated_at=>:desc)
  end

  # GET /devices/1/edit
  def edit
    @customers = Customer.order(:updated_at=>:desc)
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)
    # tmp = Device.where(:name=>@device.name)
    tmp = Device.find_by_name(@device.name)

    if tmp.nil? || tmp.blank?
      respond_to do |format|
        if @device.save
          # UserMailer.cdevice_email(@device).deliver

          du = DeviceUser.new(:username=>params[:username][:dev], :password=>params[:password][:dev], :device_name=>params[:device][:name])
          du.save

          format.html { redirect_to @device, notice: 'Device was successfully created.' }
          format.json { render :show, status: :created, location: @device }
        else
          format.html { render :new }
          format.json { render json: @device.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to devices_url, notice: 'Failed to create device. Device name was already taken by the other one.'
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    # tmp = Device.where(:name=>params[:device][:name])
    tmp = Device.find_by_name(params[:device][:name])
    bc = false

    if !tmp.nil? || !tmp.blank?
      if tmp.id == @device.id
        bc = true
      else
        bc = false
      end
    else 
      bc = true
    end 

    if bc
      respond_to do |format|
        if @device.update(device_params)
          # UserMailer.cdevice_email(@device).deliver
          # du = DeviceUser.where(:device_name=>@device.name)
          du = DeviceUser.find_by_device_name(@device.name)

          if !du.nil?
            du.update(:username=>params[:username][:dev], :password=>params[:password][:dev], :device_name=>params[:device][:name])
          else
            du = DeviceUser.new(:username=>params[:username][:dev], :password=>params[:password][:dev], :device_name=>params[:device][:name])
            du.save
          end

          format.html { redirect_to @device, notice: 'Device was successfully updated.' }
          format.json { render :show, status: :ok, location: @device }
        else
          format.html { render :edit }
          format.json { render json: @device.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to devices_url, notice: 'Failed to modify device. Device name was already taken by the other one.'
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:owner, :name, :device_type, :location, :public_ip, :private_ip, :device_note, :addons, :general_status, :general_reloaded, :osname, :osram, :osprocessor, :detail)
    end
end
