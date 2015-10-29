require 'will_paginate/array'
require 'base64'

class VerifiedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_verified, only: [:show, :edit, :update, :destroy]

  # GET /verifieds
  # GET /verifieds.json
  def index
    @verifieds = Verified.all
    # paginate
    if params[:verified_rows].nil?
      @rows = 5
    else 
      @rows = params[:verified_rows]
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
      did = Verified.to_thdindex(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    # delete verified
    if !params[:verified_id].nil?
      Verified.delete_verified(params[:verified_id])
    end

    if !params[:sort_item].nil?
      str_order = Verified.verified_sortable(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @verifieds = Verified.search(@filter_word).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    else
      @verifieds = Verified.search(@filter_word).order(str_order).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    end
    fresh_when @verifieds
    @verifieds = @verifieds.paginate(:page => params[:page], :per_page => @rows)
    
  end

  # def filter
  #   redirect_to verifieds_url, flash:{filter_str:params["_string"]}
  # end

  # def setrows
  #   redirect_to verifieds_url, flash:{rows:params["verified_rows"]}
  # end

  def quick_edit
    if params[:action] == "quick_edit"
      tc = Verified.find_by_id(params[:id])

      if !params[:username].nil? 
        aduser = User.find_by_id(params[:id])

        tp = Base64.encode64(params[:password])
        tp = tp[0,tp.length-1]
        
        if !aduser.nil?
          aduser.username = params[:username]
          aduser.password = params[:password]
          aduser.pwd = tp
          aduser.save
        end

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

  # GET /verifieds/1
  # GET /verifieds/1.json
  def show
    @devices = Device.where(:owner=>@verified.email).order(:updated_at=>:desc)
    fresh_when @devices
  end

  # GET /verifieds/new
  def new
    @verified = Verified.new
  end

  # GET /verifieds/1/edit
  def edit
    if !flash[:retry].nil? || !flash[:retry].blank?
      @retry = flash[:retry]
      @retry_params = flash[:retry_params]["verified"]
    end

    if @retry_params.blank?
      @retry_params = Account.new
    end
  end

  # POST /verifieds
  # POST /verifieds.json
  def create
    @verified = Verified.new(verified_params)

    respond_to do |format|
      if @verified.save
        # Verified was successfully created.
        format.html { redirect_to @verified, notice: '' }
        format.json { render :show, status: :created, location: @verified }
      else
        format.html { render :new }
        format.json { render json: @verified.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /verifieds/1
  # PATCH/PUT /verifieds/1.json
  def update
    tp = Base64.encode64(params[:password][:hid])
    tp = tp[0,tp.length-1]
    tu = User.find_by_username(params[:username][:hid])

    if !tu.nil? && tu.pwd == tp
      if tu.username == "CyberAdvance" || tu.is_maccount
        uu = User.find_by_id(@verified.id)
        tmp = params[:verified]

        if !uu.nil? && !tmp.blank?
          if !tmp[:password].nil?
            tp = Base64.encode64(tmp[:password])
          else
            tp = Base64.encode64(@verified.password)
          end
          tp = tp[0,tp.length-1]
          
          uu.update(:first_name => tmp[:first_name],:last_name => tmp[:last_name],:city => tmp[:city],:state => tmp[:state],:pemail => tmp[:pemail],:number => tmp[:number],:country => tmp[:country],:account_type => tmp[:account_type],:username => tmp[:username],:password => tmp[:password],:is_caccount => tmp[:is_caccount],:is_maccount => tmp[:is_maccount],:is_daccount => tmp[:is_daccount],:is_ccustomer => tmp[:is_ccustomer],:is_mcustomer => tmp[:is_mcustomer],:is_dcustomer => tmp[:is_dcustomer],:is_cdevice => tmp[:is_cdevice],:is_rdevice => tmp[:is_rdevice],:is_mdevice => tmp[:is_mdevice],:is_cticket => tmp[:is_cticket],:is_rticket => tmp[:is_rticket],:is_dticket => tmp[:is_dticket], :pwd=>tp)
        end

        respond_to do |format|
          if @verified.update(verified_params)
            # UserMailer.register_email(@verified).deliver
            # Verified was successfully updated.
            format.html { redirect_to @verified, notice: '' }
            format.json { render :show, status: :ok, location: @verified }
          else
            format.html { render :edit }
            format.json { render json: @verified.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to :back, flash:{retry:"np", retry_params: params}
      end
    else
      redirect_to :back, flash:{retry:"retry", retry_params: params}
    end
  end

  # DELETE /verifieds/1
  # DELETE /verifieds/1.json
  def destroy
    tmp = Sadmin.new(:id=>@verified.id.to_s,:username=>@verified.username,:password=>@verified.password,:email=>@verified.email,:is_rticket=>@verified.is_rticket,:is_cticket=>@verified.is_cticket,:is_dticket=>@verified.is_dticket,:is_cdevice=>@verified.is_cdevice,:is_rdevice=>@verified.is_rdevice,:is_mdevice=>@verified.is_mdevice,:is_caccount=>@verified.is_caccount,:is_maccount=>@verified.is_maccount,:is_daccount=>@verified.is_daccount,:first_name=>@verified.first_name,:last_name=>@verified.last_name,:city=>@verified.city,:state=>@verified.state,:country=>@verified.country,:pemail=>@verified.pemail,:number=>@verified.number,:account_type=>@verified.account_type,:is_ccustomer=>@verified.is_ccustomer,:is_rcustomer=>@verified.is_dcustomer,:is_mcustomer=>@verified.is_mcustomer)
    tmp.save

    # as = User.where(:id=>@verified.id)
    as = User.find_by_id(@verified.id)
    if !as.nil?
      as.destroy
    end

    @verified.destroy

    respond_to do |format|
      format.html { redirect_to verifieds_url, notice: 'Verified was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_verified
      @verified = Verified.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verified_params
      params.require(:verified).permit(:username, :password, :email, :is_rticket,:is_cticket,:is_dticket,:is_sticket,:is_cdevice,:is_rdevice,:is_mdevice, :is_caccount, :is_maccount, :is_daccount, :is_ccustomer, :is_mcustomer, :is_dcustomer, :first_name, :last_name, :city, :state, :country, :pemail, :number, :account_type )
    end
end
