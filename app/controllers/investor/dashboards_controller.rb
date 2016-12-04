class Investor::DashboardsController < Investor::ApplicationController
  def show
    @borrower_requests = BorrowerRequest.includes(user: [:profile]).all
  end
end
