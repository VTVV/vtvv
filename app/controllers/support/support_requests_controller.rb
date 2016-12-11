class Support::SupportRequestsController < Support::ApplicationController

  def show
    @support_request = SupportRequest.find(params[:id])
    @support_replies = @support_request.support_replies.order(:created_at)
    @support_reply = SupportReply.new
  end

end
