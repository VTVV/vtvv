class Borrower::RequestsController < Borrower::ApplicationController
  def index
    @requests = BorrowerRequest
                  .where(account: current_account)
                  .order(created_at: :desc)
                  .page(params[:page])
                  .per(7)
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

  def destroy
    @request = BorrowerRequest.find(params[:id])
    if @request.destroy
      flash[:success] = 'Your request has been successfully deleted!'
    else
      flash[:danger] = 'Sorry, we can\'t delete your request'
    end
    redirect_to borrower_requests_path
  end

  private

  def request_params
    params.require(:borrower_request).permit(:amount, :duration)
  end
end
