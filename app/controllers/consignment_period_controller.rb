class ConsignmentPeriodController < ApplicationController
	
   
	def daily
		@consignments = Consignment.all
		@userconsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id])
		@results = @userconsignments.where("consignments.created_at >= ?", Time.zone.now.beginning_of_day)
	end

	def weekly

	end

	def monthly

	end
end
