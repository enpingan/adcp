require 'will_paginate/array'

class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all

    if !params[:account_rows].nil?
      @accounts = Account.paginate(:page => params[:page], :per_page => params[:account_rows].to_i)
      @rows = params[:account_rows]
    end

    if params[:account_rows].nil?
      @rows = 5
    else 
      @rows = params[:account_rows]
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
      did = Account.to_thdindex(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    # delete account
    if !params[:account_id].nil?
      Account.delete_account(params[:account_id])
    end

    if !params[:sort_item].nil?
      str_order = Account.account_sortable(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @accounts = Account.search(@filter_word).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    else
      @accounts = Account.search(@filter_word).order(str_order).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    end
    fresh_when @accounts
    @accounts = @accounts.paginate(:page => params[:page], :per_page => @rows)
    
  end

  # def filter
  #   redirect_to accounts_url, flash:{filter_str:params["_string"]}
  # end

  # def setrows
  #   redirect_to accounts_url, flash:{rows:params["account_rows"]}
  # end

  # def sort
  #   redirect_to accounts_url, flash:{sort:params}
  # end

  def quick_edit
    if params[:action] == "quick_edit"
      tc = Account.find_by_id(params[:id])

      if !params[:username].nil? 
        tc.ssl_name = params[:username]
        tc.hs_pwd = params[:password]
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

  def verify
    tmp = Account.find_by_id(params[:vid])

    @vuser = Verified.new(:id=>tmp[:id], :username=>tmp[:ssl_name], :password=>tmp[:hs_pwd], :email=>tmp[:email_addr], :is_rticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket], :is_cticket=>tmp[:is_cticket], :is_cdevice=>tmp[:is_cdevice], :is_rdevice=>tmp[:is_rdevice], :is_mdevice=>tmp[:is_mdevice], :is_caccount=>tmp[:is_caccount], :is_daccount=>tmp[:is_daccount], :is_maccount=>tmp[:is_maccount],:first_name=>tmp[:first_name], :last_name=>tmp[:last_name], :city=>tmp[:city], :state=>tmp[:state], :country=>tmp[:country], :pemail=>tmp[:pemail], :number=>tmp[:number], :account_type=>tmp[:account_type], :is_mcustomer=>tmp[:is_mcustomer], :is_dcustomer=>tmp[:is_rcustomer], :is_ccustomer=>tmp[:is_ccustomer])
    @vuser.save

    tmp.email_addr = tmp.id.to_s + '@ad.com'
    @new_user = User.new(:id=>tmp[:id], :email =>tmp.email_addr, :password => tmp[:hs_pwd], :password_confirmation => tmp[:hs_pwd], :username=>tmp[:ssl_name], :pwd=>tmp[:pwd], :is_rticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket], :is_cticket=>tmp[:is_cticket], :is_cdevice=>tmp[:is_cdevice], :is_rdevice=>tmp[:is_rdevice], :is_mdevice=>tmp[:is_mdevice], :is_caccount=>tmp[:is_caccount], :is_daccount=>tmp[:is_daccount], :is_maccount=>tmp[:is_maccount],:first_name=>tmp[:first_name], :last_name=>tmp[:last_name], :city=>tmp[:city], :state=>tmp[:state], :country=>tmp[:country], :pemail=>tmp[:pemail], :number=>tmp[:number], :account_type=>tmp[:account_type], :is_mcustomer=>tmp[:is_mcustomer], :is_dcustomer=>tmp[:is_rcustomer], :is_ccustomer=>tmp[:is_ccustomer])

    if @new_user.save
      UserMailer.register_email(@new_user).deliver
    end

    tmp.delete

    redirect_to verifieds_url
  end

  # def quick_mail
  #   UserMailer.quick_email(params[:emailto], params[:subject], params[:content]).deliver
  #   redirect_to admin_url
  # end


  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @devices = Device.where(:owner=>@account.email_addr).order(:updated_at=>:desc)
    fresh_when @devices
  end

  # GET /accounts/new
  def new
    @account = Account.new

    if !flash[:retry].nil? || !flash[:retry].blank?
      @retry = flash[:retry]
      @retry_params = flash[:retry_params]["account"]
    end

    if @retry_params.blank?
      @retry_params = Account.new
    end
  end

  # GET /accounts/1/edit
  def edit
    if !flash[:retry].nil? || !flash[:retry].blank?
      @retry = flash[:retry]
      @retry_params = flash[:retry_params]["account"]
    end

    if @retry_params.blank?
      @retry_params = Account.new
    end
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    id_tmp = 100000 + rand(999999-100000)
    
    tp = Base64.encode64(params[:password][:hid])
    tp = tp[0,tp.length-1]

    # tu = User.where(:username=>params[:username][:hid]).where(:pwd=>tp)
    tu = User.find_by_username(params[:username][:hid])

    if Account.find_by_id(id_tmp).nil? && !tu.nil?
      if tu.username == "CyberAdvance" || tu.is_caccount
        @account.id = id_tmp.to_s
        tmp = params[:account]

        if @account.email_addr == "cyberadvance@admin.com"
          @vuser = Verified.new(:id=>@account.id, :username=>tmp[:ssl_name], :password=>tmp[:hs_pwd], :email=>tmp[:email_addr], :is_rticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket], :is_cticket=>tmp[:is_cticket], :is_cdevice=>tmp[:is_cdevice], :is_rdevice=>tmp[:is_rdevice], :is_mdevice=>tmp[:is_mdevice], :is_caccount=>tmp[:is_caccount], :is_daccount=>tmp[:is_daccount], :is_maccount=>tmp[:is_maccount],:first_name=>tmp[:first_name], :last_name=>tmp[:last_name], :city=>tmp[:city], :state=>tmp[:state], :country=>tmp[:country], :pemail=>tmp[:pemail], :number=>tmp[:number], :account_type=>tmp[:account_type], :is_mcustomer=>tmp[:is_mcustomer], :is_dcustomer=>tmp[:is_rcustomer], :is_ccustomer=>tmp[:is_ccustomer])

          @vuser.save

          @account.email_addr = @account.id.to_s + '@ad.com'
          @new_user = User.new(:id=>@account.id, :email =>@account.email_addr, :password => tmp[:hs_pwd], :password_confirmation => tmp[:hs_pwd], :username=>tmp[:ssl_name], :pwd=>tmp[:pwd], :is_rticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket], :is_cticket=>tmp[:is_cticket], :is_cdevice=>tmp[:is_cdevice], :is_rdevice=>tmp[:is_rdevice], :is_mdevice=>tmp[:is_mdevice], :is_caccount=>tmp[:is_caccount], :is_daccount=>tmp[:is_daccount], :is_maccount=>tmp[:is_maccount],:first_name=>tmp[:first_name], :last_name=>tmp[:last_name], :city=>tmp[:city], :state=>tmp[:state], :country=>tmp[:country], :pemail=>tmp[:pemail], :number=>tmp[:number], :account_type=>tmp[:account_type], :is_mcustomer=>tmp[:is_mcustomer], :is_dcustomer=>tmp[:is_rcustomer], :is_ccustomer=>tmp[:is_ccustomer])
          @new_user.save
          # if @new_user.save
          #   UserMailer.register_email(@new_user).deliver
          # end

          redirect_to verifieds_url
        else 
          respond_to do |format|
            if @account.save
              # UserMailer.caccount_email(@account).deliver
              # Account was successfully created.
              format.html { redirect_to @account, notice: '' }
              format.json { render :show, status: :created, location: @account }
            else
              format.html { render :new }
              format.json { render json: @account.errors, status: :unprocessable_entity }
            end

          end
        end
      else
        redirect_to :back, flash:{retry:"np", retry_params: params}
      end
    else
      redirect_to :back, flash:{retry:"retry", retry_params: params}
      # notice = 'Account email adress has been already used. Please input another one.'
      # redirect_to new_account_path
      # format.html { redirect_to new_account_path, notice: 'Account email adress has been already used. Please input another one.' }
    end 
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update

    tp = Base64.encode64(params[:password][:hid])
    tp = tp[0,tp.length-1]
    # tu = User.where(:username=>params[:username][:hid]).where(:pwd=>tp)
    tu = User.find_by_username(params[:username][:hid])

    if !tu.nil? && tu.pwd == tp
      if tu.username == "CyberAdvance" || tu.is_caccount
        respond_to do |format|
          if @account.update(account_params)
            UserMailer.caccount_email(@account).deliver
            # Account was successfully updated.
            format.html { redirect_to @account, notice: '' }
            format.json { render :show, status: :ok, location: @account }
          else
            format.html { render :edit }
            format.json { render json: @account.errors, status: :unprocessable_entity }
          end
        end
      else 
        redirect_to :back, flash:{retry:"np", retry_params: params}  
      end
    else
      redirect_to :back, flash:{retry:"retry", retry_params: params}
    end

  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      # Account was successfully destroyed.
      format.html { redirect_to accounts_url, notice: '' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:id, :email_addr, :ssl_name, :hs_pwd, :pwd, :is_rticket,:is_dticket,:is_cticket,:is_cdevice,:is_rdevice,:is_mdevice, :is_caccount, :is_maccount, :is_daccount, :first_name, :last_name, :city, :state, :country, :pemail, :number, :account_type,:is_mcustomer,:is_ccustomer,:is_rcustomer )
    end
end
