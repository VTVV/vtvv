class Investor::RequestsController < Investor::ApplicationController
  def index
    @requests = InvestorRequest.where(account: current_account)
  end

  def new
    @request = InvestorRequest.new
  end

  def create
    @request = InvestorRequest.new request_params
    @request.status = InvestorRequest.statuses[:pending]
    @request.account = current_account
    if @request.save
      flash[:success] = 'The request has been successfully sent!'
      redirect_to investor_requests_path
    else
      @errors = @request.errors.full_messages
      render 'new'
    end
  end

  def show

  end

  private

  def request_params
    params.require(:investor_request).permit(:amount,
                                             :from_rate,
                                             :to_rate,
                                             :due_date)
  end
end
