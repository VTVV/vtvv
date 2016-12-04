class SupportRequestsController < ApplicationController

  def index
    @support_requests = current_user.support_requests.order(:updated_at)
  end

  def new
    @support_request = SupportRequest.new
  end

  def create
    @support_request = SupportRequest.new(support_request_params)
    @support_request.user = current_user
    if @support_request.save
      redirect_to support_requests_path
    else
      @errors = @support_request.errors.full_messages
      render 'new'
    end
  end

  def show
    @support_request = SupportRequest.find(params[:id])
    @support_replies = @support_request.support_replies.order(:created_at)
    @support_reply = SupportReply.new
  end

  private

    def support_request_params
      params.require(:support_request).permit(:content)
    end

end
