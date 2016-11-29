class Admin::DashboardsController < Admin::ApplicationController
	def show
		@users = User.includes(:account, :profile).all
	end
end
