class ConsignmentPeriodController < ApplicationController
	
   
	def daily
		@consignments = Consignment.all
		@userconsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id])
		@start = Date.today.beginning_of_day
		@endDate = @start.end_of_day
		@range = @start..@endDate
		@results = @userconsignments.where("consignments.created_at" => @range)
	end

	def weekly
		@consignments = Consignment.all
		@userconsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id])
		@start = Date.today.beginning_of_week
		@endDate = @start.end_of_week
		@range = @start..@endDate
		@results = @userconsignments.where("consignments.created_at" =>  @range)
	end

	def monthly
		@consignments = Consignment.all
		@userconsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id])
		@start = Date.today.beginning_of_month
		@endDate = @start.end_of_month
		@range = @start..@endDate
		@results = @userconsignments.where("consignments.created_at" =>  @range)

	end
end
