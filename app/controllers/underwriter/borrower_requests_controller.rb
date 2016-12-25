class Underwriter::BorrowerRequestsController < ApplicationController

  def show
    @borrower_request = BorrowerRequest.find(params[:id])
  end

  def update
    @borrower_request = BorrowerRequest.find(params[:id])
    if @borrower_request.update_attributes(borrower_request_params)
      redirect_to underwriter_dashboard_path
    end
  end

  private

    def borrower_request_params
      params.require(:borrower_request).permit(:status)
    end

end
