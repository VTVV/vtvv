class Admin::DashboardsController < Admin::ApplicationController
	def show
		@users = User.includes(:accounts, :profile).all
	end
end
