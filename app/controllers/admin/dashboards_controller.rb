class Admin::DashboardsController < Admin::ApplicationController
	def show
		@users = User.includes(:accounts, :profile).order(id: :desc )
	end

  def ban
    user = User.find(params[:format])
    flag = user.allowed_to_log_in
    user.update(allowed_to_log_in: !flag)
    redirect_to admin_dashboard_path, 
      flash: {success: "User #{user.email} has been successfully #{user.allowed_to_log_in? ? 'unbanned' : 'banned'}"}
  end
end
