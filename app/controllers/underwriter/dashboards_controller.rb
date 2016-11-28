class Underwriter::DashboardsController < ApplicationController
	include SetProfile

	def show
    @borrower_requests = BorrowerRequest.includes(user: [:profile]).all
	end

end
