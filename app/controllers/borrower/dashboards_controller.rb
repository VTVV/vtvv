class Borrower::DashboardsController < Borrower::ApplicationController
  def show
    @investor_requests = InvestorRequest.includes(user: [:profile]).all
  end
end
