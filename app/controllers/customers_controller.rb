class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]


  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    @user_customers = Customer.where(user_id: session[:user_id])
    
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @consignments = Consignment.all
    @customerConsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id]).order('consignments.created_at DESC')
    @results = @customerConsignments.where("consignments.customer_id" => @customer.id)
    @byMonth = Consignment.all.where(customer_id: @customer.id).group_by_month(:created_at).count
    @breakDown = Consignment.all.where(customer_id: @customer.id).group_by_month(:created_at).pluck('sum(consignments.parcels)', 'sum(consignments.pallets)', 'sum(consignments.bundles)','count(consignments.created_at)')

    @customer = Customer.find(params[:id])
    @test = @customerConsignments.connection.select_all("SELECT to_char(created_at,'Mon') as mon,
                                                          extract('year' from created_at) as Year,
                                                          count(created_at) as consignments,
                                                          sum(parcels) as parcels,
                                                          sum(pallets) as pallets,
                                                          sum(bundles) as bundles
                                                        from consignments
                                                        where user_id = #{current_user.id}
                                                        and customer_id = #{@customer.id}
                                                        group by 1,2")
    @test2 = @test.rows

  end

  def customerByMonth
    @customer = Customer.find(params[:id])
    @month = params[:month]
    @year = params[:year]
    @customerId = params[:id]
    @fullDate = @month + ' '+ @year
    @startDate = @fullDate.to_date.beginning_of_month
    @endDate = @fullDate.to_date.end_of_month
    @range = @startDate..@endDate
    @consignments = Consignment.all
    @userConsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id]).order('consignments.created_at DESC')
    @customerConsignments = @userConsignments.where("consignments.customer_id" => @customerId)
    @results = @customerConsignments.where('consignments.created_at' => @range)
    @monthQuery = @results.connection.select_all("SELECT
        DATE(created_at), SUM(parcels) ,SUM(pallets), SUM(bundles),COUNT(created_at)
        FROM consignments
        WHERE created_at BETWEEN '#{@startDate}' AND '#{@endDate}'
        AND user_id = #{current_user.id}
        AND customer_id = #{@customer.id}
        GROUP BY DATE(created_at)
        ORDER BY DATE(created_at) ASC")
    @eachMonth = @monthQuery.rows

  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
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

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:customer_code, :company_name, :address1, :address2, :address3, :county, :eircode, :user_id)
    end
end
