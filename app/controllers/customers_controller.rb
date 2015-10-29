require 'will_paginate/array'

class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all

    if params[:customer_rows].nil?
      @rows = 5
    else 
      @rows = params[:customer_rows]
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
      did = Customer.to_thdindex(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    # resume device
    if !params[:did].nil?
      Customer.resume_device(params[:did][:did])
    end

    # delete customer
    if !params[:customer_id].nil?
      Customer.delete_customer(params[:customer_id])
    end

    # retry process
    if !flash[:retry].nil? || !flash[:retry].blank?
      @retry = flash[:retry]
      @retry_params = flash[:retry_params]["customer"]
    end

    if !params[:sort_item].nil?
      str_order = Customer.customer_sortable(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @customers = Customer.search(@filter_word).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    else
      @customers = Customer.search(@filter_word).order(str_order).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    end
    fresh_when @customers
    @customers = @customers.paginate(:page => params[:page], :per_page => @rows)

  end

  # def filter
  #   redirect_to customers_url, flash:{filter_str:params["_string"]}
  # end

  # def setrows
  #   redirect_to customers_url, flash:{rows:params["customer_rows"]}
  # end

  # def sort
  #   redirect_to customers_url, flash:{sort:params}
  # end

  def quick_edit
    if params[:action] == "quick_edit"
      tc = Customer.find_by_id(params[:id])

      if !params[:username].nil? 
        adevices = Device.where(:owner=>tc.username)
        fresh_when adevices

        if !adevices.blank?
          adevices.each do |a|
            a.owner = params[:username]
            a.save
          end
        end

        acustomer = User.find_by_id(params[:id])
        tp = Base64.encode64(params[:password])
        tp = tp[0,tp.length-1]

        if !acustomer.nil?
          acustomer.username = params[:username]
          acustomer.password = params[:password]
          acustomer.pwd = tp
          acustomer.save
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

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    if !flash[:retry].nil? || !flash[:retry].blank?
      @retry = flash[:retry]
      @retry_params = flash[:retry_params]["customer"]
    end

    if @retry_params.blank?
      @retry_params = Customer.new
    end

  end

  # GET /customers/1/edit
  def edit
    if !flash[:retry].nil? || !flash[:retry].blank?
      @retry = flash[:retry]
      @retry_params = flash[:retry_params]["customer"]
    end

    if @retry_params.blank?
      @retry_params = Customer.new
    end
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    @customer.id = 100000 + rand(999999-100000)
    tmp = params[:customer]

    tmail = tmp[:username].to_s + '@ca.com'

    tp = Base64.encode64(params[:password][:hid])
    tp = tp[0,tp.length-1]
    # tu = User.where(:username=>params[:username][:hid]).where(:pwd=>tp)
    tu = User.find_by_username(params[:username][:hid])
    if !tu.nil? && tu.pwd == tp
      if tu.is_ccustomer || tu.username == "CyberAdvance"
        if current_user.username == "CyberAdvance" 
          tp = Base64.encode64(tmp[:password])
          tp = tp[0,tp.length-1]

          @new_user = User.new(:id=>@customer.id.to_s, :email =>tmail, :password => tmp[:password], :password_confirmation => tmp[:password], :username=>tmp[:username], :pwd=>tp, :is_rticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket], :is_cticket=>tmp[:is_cticket], :is_cdevice=>tmp[:is_cdevice], :is_rdevice=>tmp[:is_rdevice], :is_mdevice=>tmp[:is_mdevice], :first_name => tmp[:first_name], :last_name => tmp[:last_name], :city => tmp[:city], :state => tmp[:state], :country => tmp[:country], :pemail => tmp[:pemail], :number => tmp[:number] )

          if @new_user.save
            UserMailer.register_email(@new_user).deliver
          end

          respond_to do |format|
            if @customer.save
              # Customer was successfully created.
              format.html { redirect_to @customer, notice: '' }
              format.json { render :show, status: :created, location: @customer }
            else
              format.html { render :new }
              format.json { render json: @customer.errors, status: :unprocessaale_entity }
            end
          end
        else
          ps = Pcustomer.new(:id=>@customer.id.to_s, :username=>tmp[:username], :password=>tmp[:password], :is_rticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket], :is_wticket=>tmp[:is_wticket], :is_sticket=>tmp[:is_sticket], :is_cdevice=>tmp[:is_cdevice], :is_rdevice=>tmp[:is_rdevice], :is_mdevice=>tmp[:is_mdevice], :first_name=>tmp[:first_name], :last_name=>tmp[:last_name], :city=>tmp[:city], :state=>tmp[:state], :country=>tmp[:country], :pemail=>tmp[:pemail], :number=>tmp[:number], :account_type=>tmp[:account_type])
          ps.save

          redirect_to pcustomers_url
        end
      else
        redirect_to :back, flash:{retry:"np", retry_params:params}
      end
    else
      redirect_to :back, flash:{retry:"retry", retry_params:params}
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    tp = Base64.encode64(params[:password][:hid])
    tp = tp[0,tp.length-1]
    # tu = User.where(:username=>params[:username][:hid]).where(:pwd=>tp)
    tu = User.find_by_username(params[:username][:hid])

    # if Customer.where(:id=>@customer.id.to_s).blank? && !tu.blank?
    if !tu.nil? && tu.pwd == tp
      if tu.username == "CyberAdvance" || tu.is_ccustomer
        uuser = User.find_by_id(@customer.id.to_s)

        if !uuser.nil? || !uuser.blank?
          tmail = uuser.email
          tmp = params[:customer]

          if !tmp[:password].nil?
            tp = Base64.encode64(tmp[:password])
          else
            tp = Base64.encode64(@customer.password)
          end
          tp = tp[0,tp.length-1]

          uuser.update(:id=>@customer.id.to_s, :email =>tmail, :password => tmp[:password], :password_confirmation => tmp[:password], :username=>tmp[:username], :pwd=>tmp[:password], :is_rticket=>tmp[:is_rticket], :is_dticket=>tmp[:is_dticket], :is_cticket=>tmp[:is_cticket], :is_cdevice=>tmp[:is_cdevice], :is_rdevice=>tmp[:is_rdevice], :is_mdevice=>tmp[:is_mdevice], :first_name => tmp[:first_name], :last_name => tmp[:last_name], :city => tmp[:city], :state => tmp[:state], :country => tmp[:country], :pemail => tmp[:pemail], :number => tmp[:number] )

          if params[:changing_order] == 'change'
            Device.change_owner(params[:cus_username], params[:customer][:username])
          end
        end

        respond_to do |format|
          if @customer.update(customer_params)
            UserMailer.register_email(@customer).deliver
            # Customer was successfully updated.
            format.html { redirect_to @customer, notice: '' }
            format.json { render :show, status: :ok, location: @customer }
          else
            format.html { render :edit }
            format.json { render json: @customer.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to :back, flash:{retry:"np", retry_params:params}
      end
    else
      redirect_to :back, flash:{retry:"retry", retry_params:params}
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    # as = User.where(:id=>@customer.id)
    as = User.find_by_id(@customer.id)

    sc = Scustomer.new(:id=>@customer.id.to_s, :username=>as.username, :password=>as.pwd, :is_rticket=>as.is_rticket,:is_wticket=>as.is_rticket,:is_dticket=>as.is_rticket,:is_sticket=>as.is_rticket,:is_cdevice=>as.is_cdevice,:is_rdevice=>as.is_rdevice,:is_mdevice=>as.is_mdevice,:first_name=>as.first_name, :last_name=>as.last_name, :city=>as.city, :state=>as.state, :country=>as.country, :number=>as.number, :pemail=>as.pemail)
    
    if sc.save
      as.destroy
    end  
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:username, :password, :is_rticket,:is_wticket,:is_dticket,:is_sticket,:is_cdevice,:is_rdevice,:is_mdevice,:first_name, :last_name, :city, :state, :country, :number, :pemail )
    end
end
