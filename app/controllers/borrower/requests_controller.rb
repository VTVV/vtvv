class Borrower::RequestsController < Borrower::ApplicationController
  def index
    @requests = BorrowerRequest.where(account: current_account)
  end

  def new
    @request = BorrowerRequest.new
  end

  def create
    @request = BorrowerRequest.new request_params
    @request.status = BorrowerRequest.statuses[:pending]
    @request.account = current_account
    if @request.save
      flash[:success] = 'The request was successfully sent!'
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