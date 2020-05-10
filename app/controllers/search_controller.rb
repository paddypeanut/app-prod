class SearchController < ApplicationController

	def search

	end

	def search_results
		@consignments = Consignment.joins(:customer).includes(:user).where(user: session[:user_id]).order('consignments.created_at DESC')
			if params[:search].blank?
				@parameter = '0'
			else
				@parameter = params[:search]
			end
		@results = @consignments.all.where("customers.customer_code ILIKE ? OR customers.company_name ILIKE ? OR consignments.reference ILIKE ?", "%#{@parameter}%" , "%#{@parameter}%", "%#{@parameter}%").paginate(:page => params[:page], :per_page => 25)
	end

	def search_date

	end

	def search_date_results
		@consignments = Consignment.joins(:customer).includes(:user).where(user: session[:user_id]).order('consignments.created_at DESC')

		if params[:startdate].blank? && params[:enddate].blank?
			@startDate = Date.today.beginning_of_day
			@endDate = Date.today.end_of_day
		else
			@startDate = params[:startdate].to_date.beginning_of_day
			@endDate = params[:enddate].to_date.end_of_day
		end

		@range = @startDate..@endDate
		@results = @consignments.where("consignments.created_at" => @range).paginate(:page => params[:page], :per_page => 25)

	end
end
