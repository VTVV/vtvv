class Support::DashboardsController < Support::ApplicationController
  def show
    @support_requests = SupportRequest.latest_support_replies
  end
end
