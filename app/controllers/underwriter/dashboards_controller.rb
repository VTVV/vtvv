class Underwriter::DashboardsController < ApplicationController

  def show
    @borrower_requests = BorrowerRequest.includes(account: { user: [:profile]}).all
  end

end
