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
