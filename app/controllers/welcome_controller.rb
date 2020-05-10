class WelcomeController < ApplicationController
	def index
		@consignments = Consignment.all
    	@userConsignments = @consignments.joins(:customer).includes(:user).where(user: session[:user_id])

		@today = Date.today
		@yesterday = @today - 1.day
		@todayRange = @today.beginning_of_day..@today.end_of_day
		@yesterdayRange = @yesterday.beginning_of_day..@yesterday.end_of_day

		@todayConsignments = @userConsignments.where('consignments.created_at' => @todayRange)
		@todayBreakdown = @todayConsignments.pluck('count(consignments.created_at)','sum(consignments.parcels)','sum(consignments.pallets)','sum(consignments.bundles)')

		@yesterdayConsignments = @userConsignments.where('consignments.created_at' => @yesterdayRange)
		@yesterdayBreakdown = @yesterdayConsignments.pluck('count(consignments.created_at)','sum(consignments.parcels)','sum(consignments.pallets)','sum(consignments.bundles)')

		@weekStart = @today.beginning_of_week.beginning_of_day
		@weekEnd = @weekStart.end_of_week.end_of_day
		@weekRange = @weekStart..@weekEnd
		@weekConsignments = @userConsignments.where('consignments.created_at' => @weekRange)
		@weekBreakdown = @weekConsignments.pluck('count(consignments.created_at)','sum(consignments.parcels)','sum(consignments.pallets)','sum(consignments.bundles)')
		@weekByDay = @weekConsignments.group_by_day('consignments.created_at').count
		@weekQuery = @weekConsignments.connection.select_all("SELECT
				DATE(created_at), SUM(parcels) ,SUM(pallets), SUM(bundles),COUNT(created_at)
				FROM consignments
				WHERE created_at BETWEEN '#{@weekStart}' AND '#{@weekEnd}'
				AND user_id = #{current_user.id}
				GROUP BY DATE(created_at)
				ORDER BY DATE(created_at) ASC")
		@weekFull = @weekQuery.rows

		@monthStart = @today.beginning_of_month.beginning_of_day
		@monthEnd = @monthStart.end_of_month.end_of_day
		@monthRange = @monthStart..@monthEnd
		@monthConsignments = @userConsignments.where('consignments.created_at' => @monthRange)
		@monthByDay = @monthConsignments.group_by_day('consignments.created_at').count
		@monthBreakdown = @monthConsignments.pluck('count(consignments.created_at)','sum(consignments.parcels)','sum(consignments.pallets)','sum(consignments.bundles)')
		@monthQuery = @monthConsignments.connection.select_all("SELECT
				DATE(created_at), SUM(parcels) ,SUM(pallets), SUM(bundles),COUNT(created_at)
				FROM consignments
				WHERE created_at BETWEEN '#{@monthStart}' AND '#{@monthEnd}'
				AND user_id = #{current_user.id}
				GROUP BY DATE(created_at)
				ORDER BY DATE(created_at) ASC")
		@monthFull = @monthQuery.rows


	end
	
end
