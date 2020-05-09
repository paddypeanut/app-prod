class ConsignmentsController < ApplicationController
  before_action :set_consignment, only: [:show, :edit, :update, :destroy]

  # GET /consignments
  # GET /consignments.json
  def index
    @consignments = Consignment.all
    @results = @consignments.joins(:customer).includes(:user).where(user: session[:user_id]).order('consignments.created_at DESC')
  end

  # GET /consignments/1
  # GET /consignments/1.json
  def show
  end

  # GET /consignments/new
  def new
    @consignment = Consignment.new
    @customers = Customer.joins(:user).where(user: session[:user_id])
  end


  def show_panel
    @consignments = Consignment.all
    @userConsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id]).order('consignments.created_at DESC')
  
    if params[:filter] == 'Today'
        @startDate = Date.today.beginning_of_day
        @endDate = @startDate.end_of_day 
        @heading = "today"
      elsif params[:filter] == 'Yesterday'
        @startDate = Date.today.beginning_of_day - 1.day
        @endDate = @startDate.end_of_day
        @heading = "yesterday"
      elsif params[:filter] == 'Week'
        @startDate = Date.today.beginning_of_week
        @endDate = @startDate.end_of_week
        @heading = "this week"
      elsif params[:filter] == 'Month'
        @startDate = Date.today.beginning_of_month
        @endDate = Date.today.end_of_month
        @heading = "this month"
    end
    @range = @startDate..@endDate
    @results = @userConsignments.where('consignments.created_at' => @range)
  end

  def by_date 
    @consignments = Consignment.all
    @userConsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id]).order('consignments.created_at DESC')
    @startDate = params[:startdate].to_date
    @endDate = params[:enddate].to_date
    @range = @startDate.beginning_of_day..@endDate.end_of_day
    @results = @userConsignments.where('consignments.created_at' => @range)
  end

  # GET /consignments/1/edit
  def edit
  end

  # POST /consignments
  # POST /consignments.json
  def create
    @consignment = Consignment.new(consignment_params)

    respond_to do |format|
      if @consignment.save
        format.html { redirect_to @consignment, notice: 'Consignment was successfully created.' }
        format.json { render :show, status: :created, location: @consignment }
      else
        format.html { render :new }
        format.json { render json: @consignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consignments/1
  # PATCH/PUT /consignments/1.json
  def update
    respond_to do |format|
      if @consignment.update(consignment_params)
        format.html { redirect_to @consignment, notice: 'Consignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @consignment }
      else
        format.html { render :edit }
        format.json { render json: @consignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consignments/1
  # DELETE /consignments/1.json
  def destroy
    @consignment.destroy
    respond_to do |format|
      format.html { redirect_to consignments_url, notice: 'Consignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consignment
      @consignment = Consignment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def consignment_params
      params.require(:consignment).permit(:company_code ,:customer_id, :reference, :parcels, :pallets, :bundles,:user_id)
    end
end
