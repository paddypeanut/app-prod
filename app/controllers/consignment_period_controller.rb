class ConsignmentPeriodController < ApplicationController
	
   
	def daily
		@consignments = Consignment.all
		@userconsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id])
		@results = @userconsignments.where("consignments.created_at >= ?", Time.zone.now.beginning_of_day)
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

	end
end
