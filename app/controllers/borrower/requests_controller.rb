class Borrower::RequestsController < Borrower::ApplicationController
  def index
    @requests = BorrowerRequest.where(account: current_account)
  end

  def new
    if current_user.confirmed?
      @request = BorrowerRequest.new
    else
      flash[:alert] = 'In order to create requests please confirm your account.'
      redirect_to borrower_dashboard_path
    end

  end

  def create
    @request = BorrowerRequest.new request_params
    @request.status = BorrowerRequest.statuses[:pending]
    @request.account = current_account
    if @request.save
      flash[:success] = 'The request has been successfully sent!'
      redirect_to borrower_requests_path
    else
      @errors = @request.errors.full_messages
      render 'new'
    end
  end

  def show

  end

  private

  def request_params
    params.require(:borrower_request).permit(:amount, :duration)
  end
end
