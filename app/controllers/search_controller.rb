class SearchController < ApplicationController

	def search

	end

	def search_results
		@consignments = Consignment.joins(:customer).includes(:user).where(user: session[:user_id]).order('consignments.created_at DESC')
			if params[:search].blank?
				@parameter = 'hello'
			else
				@parameter = params[:search]
				@test = @consignments.all
				@results = @consignments.all.where("customers.customer_code ILIKE ? OR customers.company_name ILIKE ? OR consignments.reference ILIKE ?", "%#{@parameter}%" , "%#{@parameter}%", "%#{@parameter}%")
			end
	end
end
