require 'will_paginate/array'

class ScustomersController < ApplicationController
  before_action :set_scustomer, only: [:show, :edit, :update, :destroy]

  # GET /scustomers
  # GET /scustomers.json
  def index
    @scustomers = Scustomer.all

    if params[:scustomer_rows].nil?
      @rows = 5
    else 
      @rows = params[:scustomer_rows]
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
      did = Scustomer.to_thdindex(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    # delete scustomer
    if !params[:scustomer_id].nil?
      Scustomer.delete_scustomer(params[:scustomer_id])
    end

    if !params[:sort_item].nil?
      str_order = Scustomer.scustomer_sortable(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @scustomers = Scustomer.search(@filter_word).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    else
      @scustomers = Scustomer.search(@filter_word).order(str_order).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    end
    fresh_when @scustomers
    
    # retry process
    flash[:filter_str] = ""

    if !flash[:retry].nil? || !flash[:retry].blank?
      @retry = flash[:retry]
    end
  end

  def filter
    redirect_to scustomers_url, flash:{filter_str:params["_string"]}
  end

  def setrows
    redirect_to scustomers_url, flash:{rows:params["scustomer_rows"]}
  end

  def quick_edit
    if params[:action] == "quick_edit"
      tc = Scustomer.find_by_id(params[:id])

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

  # GET /scustomers/1
  # GET /scustomers/1.json
  def show
  end

  # GET /scustomers/new
  def new
    @scustomer = Scustomer.new
  end

  # GET /scustomers/1/edit
  def edit
    if !flash[:retry].nil? || !flash[:retry].blank?
      @retry = flash[:retry]
      @retry_params = flash[:retry_params]["scustomer"]
    end

    if @retry_params.blank?
      @retry_params = Scustomer.new
    end
  end

  def verify
    tmp = Scustomer.find_by_id(params[:vid])

    sc = Customer.new(:id=>params[:vid].to_s, :username=>tmp[:username], :password=>tmp[:password], :is_rticket=>tmp[:is_rticket] ,:is_wticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_rticket],:is_sticket=>tmp[:is_rticket] ,:is_cdevice=>tmp[:is_cdevice] ,:is_rdevice=>tmp[:is_rdevice] ,:is_mdevice=>tmp[:is_mdevice] ,:first_name=>tmp[:first_name], :last_name=>tmp[:last_name], :city=>tmp[:city], :state=>tmp[:state], :country=>tmp[:country], :number=>tmp[:number], :pemail=>tmp[:pemail] )
    

    if sc.save

      tmail = params[:vid].to_s + '@ca.com'
      @new_user = User.new(:id=>params[:vid].to_s, :email =>tmail, :username=>tmp[:username], :password=>tmp[:password], :pwd=>tmp[:password], :is_rticket=>tmp[:is_rticket], :is_cticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket] ,:is_cdevice=>tmp[:is_cdevice] ,:is_rdevice=>tmp[:is_rdevice] ,:is_mdevice=>tmp[:is_mdevice], :first_name=>tmp[:first_name], :last_name=>tmp[:last_name], :city=>tmp[:city], :state=>tmp[:state], :country=>tmp[:country], :number=>tmp[:number], :pemail=>tmp[:pemail])

      if @new_user.save
        tmp.delete
      end
    end

    # if @new_user.save
    #   UserMailer.register_email(@new_user).deliver
    # end

    redirect_to customers_url
  end

  # POST /scustomers
  # POST /scustomers.json
  def create
    @scustomer = Scustomer.new(scustomer_params)

    respond_to do |format|
      if @scustomer.save
        format.html { redirect_to @scustomer, notice: 'Scustomer was successfully created.' }
        format.json { render :show, status: :created, location: @scustomer }
      else
        format.html { render :new }
        format.json { render json: @scustomer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scustomers/1
  # PATCH/PUT /scustomers/1.json
  def update
    tp = Base64.encode64(params[:password][:hid])
    tp = tp[0,tp.length-1]
    # tu = User.where(:username=>params[:username][:hid]).where(:pwd=>tp)
    tu = User.find_by_username(params[:username][:hid])

    # if Customer.where(:id=>@customer.id.to_s).blank? && !tu.blank?
    if !tu.nil? && tu.pwd == tp
      if tu.username == "CyberAdvance" || tu.is_ccustomer
        respond_to do |format|
          if @scustomer.update(scustomer_params)
            format.html { redirect_to @scustomer, notice: 'Scustomer was successfully updated.' }
            format.json { render :show, status: :ok, location: @scustomer }
          else
            format.html { render :edit }
            format.json { render json: @scustomer.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to :back, flash:{retry:"np", retry_params:params}
      end
    else
      redirect_to :back, flash:{retry:"retry", retry_params:params}
    end
  end

  # DELETE /scustomers/1
  # DELETE /scustomers/1.json
  def destroy
    @scustomer.destroy
    respond_to do |format|
      format.html { redirect_to scustomers_url, notice: 'Scustomer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scustomer
      @scustomer = Scustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scustomer_params
      params.require(:scustomer).permit(:username, :password, :is_rticket, :is_wticket, :is_dticket, :is_sticket, :is_cdevice, :is_rdevice, :is_mdevice, :first_name, :last_name, :city, :state, :country, :pemail, :number, :account_type)
    end
end
