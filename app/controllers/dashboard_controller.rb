require 'will_paginate/array'
require 'geoip2'

# class AdminController < ApplicationController
class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    tmp = current_user.username.to_s

    @devices = Device.order(:updated_at=>:desc)
    @device_count = @devices.count

    if !@devices.blank?
      @r_device1 = @devices.first
    end

    if @devices.count >= 2
      @r_device2 = @devices[1]
    else
      @r_device2 = nil
    end

    @tickets = Ticket.where(:is_read=>true).order(:updated_at=>:desc)
    fresh_when @tickets

    @ticket_count = @tickets.count

    if !@tickets.blank?
      @r_ticket1 = @tickets.first
    end

    if @tickets.count >= 2
      @r_ticket2 = @tickets[1]
    else
      @r_ticket2 = nil
    end

    # @accounts = User.order(:last_sign_in_at=>:desc)
    @accounts = User.where('last_sign_in_ip > 0').order(:last_sign_in_at=>:desc)

    @customers = Customer.order(:updated_at=>:desc)
    if !@customers.blank?
      @customer1 = @customers.first
    end

    if @customers.count >= 2
      @customer2 = @tickets[1]
    else
      @customer2 = nil
    end

    @pcustomers = Pcustomer.order(:updated_at=>:desc)
    if !@pcustomers.blank?
      @pcustomer1 = @pcustomers.first
    end

    if @pcustomers.count >= 2
      @pcustomer2 = @tickets[1]
    else
      @pcustomer2 = nil
    end

    @paccounts = Account.order(:updated_at=>:desc)
    if !@paccounts.blank?
      @paccount1 = @paccounts.first
    end

    if @paccounts.count >= 2
      @paccount2 = @tickets[1]
    else
      @paccount2 = nil
    end

    # sort
    @thd = []
    
    if !params[:sort_item].nil?
      did = Account.to_thdindex2(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    if !params[:sort_item].nil?
      str_order = Account.account_sortable2(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @accounts = User.where('last_sign_in_ip > 0').order(:last_sign_in_at=>:desc).paginate(:page => params[:page], :per_page => 5)
    else
      @accounts = User.where('last_sign_in_ip > 0').order(str_order).order(:last_sign_in_at=>:desc).paginate(:page => params[:page], :per_page => 5)
    end

    # send quick email
    if !params[:quick_mail].blank?
      UserMailer.quick_email(params[:quick_mail][:emailto], params[:quick_mail][:subject], params[:quick_mail][:content]).deliver
    end

    # https://geoip.maxmind.com/geoip/v2.1/insights/{ip_address}
    # begin
    #   ip_info = Geoip2.insights('173.255.164.189')
    # rescue
    #   puts "Something was taken on maxmind part"
    # ensure 
    #   puts ip_info
    # end

    # db = MaxMindDB.new('./GeoLite2-City.mmdb')
    # ret = db.lookup('46.23.66.190')
    # binding.pry

  end

  def show_userinfo
    if !params[:name].nil?
      user = Customer.find_by_username(params[:name])

      if user.nil?
        user = Verified.find_by_username(params[:name])
      end
    end

    if !params[:id].nil?
      user = Customer.find_by_id(params[:id])

      if user.nil?
        user = Verified.find_by_id(params[:id])
      end
    end

    if user.nil?
      render dashboard_url
    else
      redirect_to user
    end

  end

  def userinfo
    if !params[:gokey].nil?
      case params[:gokey]
      when "admin"
        @users = User.where('last_sign_in_ip > 0').where('NOT ISNULL(account_type) ')
      when "customer"
        @users = User.where('last_sign_in_ip > 0').where('ISNULL(account_type)')
      else
        @users = Visitor.all
      end
    else 
      @users = Visitor.all
    end

    @gokey = params[:gokey]
  end

  def search 
    case params["skey"]

    when "Public IP"
      @devices = Device.where("public_ip LIKE ?", "%#{params["filter_word"]}%")
    when "Private IP"
      @devices = Device.where("private_ip LIKE ?", "%#{params["filter_word"]}%")
    when "Username"
      @devices = Device.where("owner LIKE ?", "%#{params["filter_word"]}%")
      @customers = Customer.where("username LIKE ?", "%#{params["filter_word"]}%")
      @verifieds = Verified.where("username LIKE ?", "%#{params["filter_word"]}%")
      @tickets = Ticket.where("owner LIKE ?", "%#{params["filter_word"]}%")
    when "Email Adress"
      @verifieds = Verified.where("pemail LIKE ?", "%#{params["filter_word"]}%")
      @customers = Customer.where("pemail LIKE ?", "%#{params["filter_word"]}%")
    else
      @devices = Device.where("public_ip LIKE ? or private_ip LIKE ? or owner LIKE ?", "%#{params["filter_word"]}%", "%#{params["filter_word"]}%", "%#{params["filter_word"]}%")
      @customers = Customer.where("username LIKE ? or pemail LIKE ?", "%#{params["filter_word"]}%", "%#{params["filter_word"]}%")
      @verifieds = Verified.where("username LIKE ? or pemail LIKE ?", "%#{params["filter_word"]}%", "%#{params["filter_word"]}%")
    end
  end

end
