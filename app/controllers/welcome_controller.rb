class WelcomeController < ApplicationController
	def index
		@consignments = Consignment.all
    	@userConsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id])

		@today = Date.today
		@yesterday = @today - 1.day
		@todayRange = @today.beginning_of_day..@today.end_of_day
		@yesterdayRange = @yesterday.beginning_of_day..@yesterday.end_of_day

		@todayConsignments = @consignments.where('consignments.created_at' => @todayRange)
		@todayBreakdown = @todayConsignments.pluck('count(consignments.created_at)','sum(consignments.parcels)','sum(consignments.pallets)','sum(consignments.bundles)')

		@yesterdayConsignments = @consignments.where('consignments.created_at' => @yesterdayRange)
		@yesterdayBreakdown = @yesterdayConsignments.pluck('count(consignments.created_at)','sum(consignments.parcels)','sum(consignments.pallets)','sum(consignments.bundles)')

		@weekStart = @today.beginning_of_week
		@weekEnd = @weekStart.end_of_week
		@weekRange = @weekStart..@weekEnd
		@weekConsignments = @consignments.where('consignments.created_at' => @weekRange)
		@weekBreakdown = @weekConsignments.pluck('count(consignments.created_at)','sum(consignments.parcels)','sum(consignments.pallets)','sum(consignments.bundles)')
		@weekByDay = @weekConsignments.group_by_day('consignments.created_at').count


		@monthStart = @today.beginning_of_month
		@monthEnd = @monthStart.end_of_month
		@monthRange = @monthStart..@monthEnd
		@monthConsignments = @consignments.where('consignments.created_at' => @monthRange)
		@monthBreakdown = @monthConsignments.pluck('count(consignments.created_at)','sum(consignments.parcels)','sum(consignments.pallets)','sum(consignments.bundles)')


	end
	
end
