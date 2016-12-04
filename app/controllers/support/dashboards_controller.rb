class Support::DashboardsController < Support::ApplicationController
	def show
    @support_requests = SupportRequest.all
	end
end
