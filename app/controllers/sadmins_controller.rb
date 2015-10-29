require 'will_paginate/array'
require 'base64'

class SadminsController < ApplicationController
  before_action :set_sadmin, only: [:show, :edit, :update, :destroy]

  # GET /sadmins
  # GET /sadmins.json
  def index
    @sadmins = Sadmin.all

    if params[:sadmin_rows].nil?
      @rows = 5
    else 
      @rows = params[:sadmin_rows]
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
      did = Sadmin.to_thdindex(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    # delete verified
    if !params[:sadmin_id].nil?
      Sadmin.delete_sadmin(params[:sadmin_id])
    end

    if !params[:sort_item].nil?
      str_order = Sadmin.sadmin_sortable(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @sadmins = Sadmin.search(@filter_word).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    else
      @sadmins = Sadmin.search(@filter_word).order(str_order).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    end
    fresh_when @sadmins
    @sadmins = @sadmins.paginate(:page => params[:page], :per_page => @rows)
    
  end

  def filter
    redirect_to sadmins_url, flash:{filter_str:params["_string"]}
  end

  def setrows
    redirect_to sadmins_url, flash:{rows:params["sadmin_rows"]}
  end

  # GET /sadmins/1
  # GET /sadmins/1.json
  def show
    @devices = Device.where(:owner=>@sadmin.email).order(:updated_at=>:desc)
  end

  def quick_edit
    if params[:action] == "quick_edit"
      tc = Sadmin.find_by_id(params[:id])

      if !params[:username].nil? 
        tc.username = params[:username]
        tc.password = params[:password]
        tc.save
      end

      if !params[:first_name].nil? 
        tc.first_name = params[:first_name]
        tc.last_name = params[:last_name]
        tc.pemail = params[:pemail]
        tc.number = params[:number]
        tc.city = params[:city]
        tc.state = params[:state]
        tc.save
      end

    end

    render json:nil, status: :ok
  end

  # GET /sadmins/new
  def new
    @sadmin = Sadmin.new
  end

  # GET /sadmins/1/edit
  def edit
    if !flash[:retry].nil? || !flash[:retry].blank?
      @retry = flash[:retry]
      @retry_params = flash[:retry_params]["sadmin"]
    end

    if @retry_params.blank?
      @retry_params = Account.new
    end
  end

  def verify
    tmp = Sadmin.find_by_id(params[:vid])

    @vuser = Verified.new(:id=>tmp[:id], :username=>tmp[:username], :password=>tmp[:password], :email=>tmp[:email], :is_rticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket], :is_cticket=>tmp[:is_cticket], :is_cdevice=>tmp[:is_cdevice], :is_rdevice=>tmp[:is_rdevice], :is_mdevice=>tmp[:is_mdevice], :is_caccount=>tmp[:is_caccount], :is_daccount=>tmp[:is_daccount], :is_maccount=>tmp[:is_maccount],:first_name=>tmp[:first_name], :last_name=>tmp[:last_name], :city=>tmp[:city], :state=>tmp[:state], :country=>tmp[:country], :pemail=>tmp[:pemail], :number=>tmp[:number], :account_type=>tmp[:account_type], :is_mcustomer=>tmp[:is_mcustomer], :is_dcustomer=>tmp[:is_rcustomer], :is_ccustomer=>tmp[:is_ccustomer])
    @vuser.save

    tmail = tmp.id.to_s + '@ad.com'
    @new_user = User.new(:id=>tmp[:id], :email =>tmail, :password => tmp[:password], :password_confirmation => tmp[:password], :username=>tmp[:username], :pwd=>tmp[:password], :is_rticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket], :is_cticket=>tmp[:is_cticket], :is_cdevice=>tmp[:is_cdevice], :is_rdevice=>tmp[:is_rdevice], :is_mdevice=>tmp[:is_mdevice], :is_caccount=>tmp[:is_caccount], :is_daccount=>tmp[:is_daccount], :is_maccount=>tmp[:is_maccount],:first_name=>tmp[:first_name], :last_name=>tmp[:last_name], :city=>tmp[:city], :state=>tmp[:state], :country=>tmp[:country], :pemail=>tmp[:pemail], :number=>tmp[:number], :account_type=>tmp[:account_type], :is_mcustomer=>tmp[:is_mcustomer], :is_dcustomer=>tmp[:is_rcustomer], :is_ccustomer=>tmp[:is_ccustomer])

    if @new_user.save
      UserMailer.register_email(@new_user).deliver
    end

    tmp.delete

    redirect_to verifieds_url
  end

  # POST /sadmins
  # POST /sadmins.json
  def create
    @sadmin = Sadmin.new(sadmin_params)

    respond_to do |format|
      if @sadmin.save
        # Sadmin was successfully created.
        format.html { redirect_to @sadmin, notice: '' }
        format.json { render :show, status: :created, location: @sadmin }
      else
        format.html { render :new }
        format.json { render json: @sadmin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sadmins/1
  # PATCH/PUT /sadmins/1.json
  def update
    tp = Base64.encode64(params[:password][:hid])
    tp = tp[0,tp.length-1]
    tu = User.where(:username=>params[:username][:hid]).where(:pwd=>tp)

    if !tu.blank?
      if tu[0].username == "CyberAdvance" || tu[0].is_caccount
        respond_to do |format|
          if @sadmin.update(sadmin_params)
            # Sadmin was successfully updated.
            format.html { redirect_to @sadmin, notice: '' }
            format.json { render :show, status: :ok, location: @sadmin }
          else
            format.html { render :edit }
            format.json { render json: @sadmin.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to :back, flash:{retry:"np", retry_params: params}  
      end
    else
      redirect_to :back, flash:{retry:"retry", retry_params: params}  
    end
  end

  # DELETE /sadmins/1
  # DELETE /sadmins/1.json
  def destroy
    @sadmin.destroy
    respond_to do |format|
      format.html { redirect_to sadmins_url, notice: 'Sadmin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sadmin
      @sadmin = Sadmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sadmin_params
      params.require(:sadmin).permit(:username, :password, :email, :is_rticket,:is_wticket,:is_dticket,:is_cticket,:is_cdevice,:is_rdevice,:is_mdevice, :is_caccount, :is_maccount, :is_daccount, :is_ccustomer, :is_mcustomer, :is_rcustomer, :first_name, :last_name, :city, :state, :country, :pemail, :number, :account_type )
    end
end
