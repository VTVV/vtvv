class Underwriter::DashboardsController < ApplicationController

  def show
    @borrower_requests = BorrowerRequest.includes(user: [:profile]).all
  end

end
