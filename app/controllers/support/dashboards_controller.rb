class Support::DashboardsController < Support::ApplicationController
  def show
    @support_requests = SupportRequest.order(updated_at: :desc)
  end
end
