class Admin::DashboardsController < Admin::ApplicationController
	include SetProfile
	def show
		@users = User.includes(:account, :profile).all
	end
end
