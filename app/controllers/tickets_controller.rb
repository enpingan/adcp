require 'will_paginate/array'

class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index

    if current_user.username == "CyberAdvance" || current_user.is_rticket || current_user.is_dticket || current_user.is_cticket
      @tickets = Ticket.order(:is_read=>:desc).order(:updated_at=>:desc)
    else
      @tickets = Ticket.where(:owner=>current_user.username).order(:is_read=>:desc).order(:updated_at=>:desc)
    end

    # paginate
    if params[:ticket_rows].nil?
      @rows = 5
    else 
      @rows = params[:ticket_rows]
    end

    if params[:page].nil?
      @page_number = 1
    else
      @page_number = params[:page]
    end

    # search
    @filter_word = params[:search]    

    # sort
    @thd = []
    
    if !params[:sort_item].nil?
      did = Ticket.to_thdindex(params[:sort_item])

      if params[:direction] != ""
        if params[:direction] == "desc"
          @thd[did] = "_d"
        else
          @thd[did] = "_a"
        end
      end
    end

    # delete ticket ajax
    if !params[:ticket_id].nil?
      Ticket.delete_ticket(params[:ticket_id])
    end

    if !params[:sort_item].nil?
      str_order = Ticket.ticket_sortable(params[:sort_item], params[:direction])
    end
    
    if str_order.nil?
      @tickets = Ticket.search(@filter_word).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    else
      @tickets = Ticket.search(@filter_word).order(str_order).order(:updated_at=>:desc).paginate(:page => params[:page], :per_page => @rows)
    end
    fresh_when @tickets
    
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    # add comment
    if !params[:tid].nil?
      Ticket.add_comment(params, current_user.username)
    end

    # delete comment
    if !params[:comment_id].nil?
      Ticket.delete_comment(params)
    end

    @ticket = Ticket.find_by_id(params[:id])
    @ticket.is_read = false

    @ticket.save

    tid = @ticket.id.to_s
    @comments = Comment.where(:ticket_id=>tid).order(:updated_at=>:desc)

    if current_user.username != "CyberAdvance" && !current_user.is_rticket && !current_user.is_dticket && !current_user.is_cticket
      tmp = current_user.username

      @comments = Comment.where(:ticket_owner=>tmp).where(:ticket_id=>tid).order(:updated_at=>:desc)
    end

    fresh_when @comments
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @devices = Device.all
    # @verifieds = Verified.all
    @customers = Customer.all
  end

  # GET /tickets/1/edit
  def edit
    # add comment
    if !params[:comment].nil?
      Ticket.add_comment(params, current_user.username)
    end

    # delete comment
    if !params[:comment_id].nil?
      Ticket.delete_comment(params)
    end

    @devices = Device.all
    fresh_when @devices

    @customers = Customer.all
    fresh_when @customers

    tid = @ticket.id.to_s
    
    @comments = Comment.where(:ticket_id=>tid).order(:updated_at=>:desc)
    fresh_when @comments

    if current_user.username != "CyberAdvance" && !current_user.is_rticket && !current_user.is_dticket && !current_user.is_cticket
      tmp = current_user.username

      @comments = Comment.where(:ticket_owner=>tmp).where(:ticket_id=>tid).order(:updated_at=>:desc)
      fresh_when @comments
    end

  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.id = 100000 + rand(999999-100000)

    respond_to do |format|
      if @ticket.save
        # format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.html { redirect_to tickets_url, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        #format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.html { redirect_to tickets_url, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:ticket_group, :subject, :owner, :last_replied, :device, :updated, :user_id, :is_read, :detail)
    end
end
