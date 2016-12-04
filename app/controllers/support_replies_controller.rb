class SupportRepliesController < ApplicationController

  def create
    @support_reply = SupportReply.new(support_reply_params)
    @support_reply.user = current_user
    @support_request = @support_reply.support_request
    if @support_reply.save
      redirect_to support_request_path(@support_request)
    else
      @errors = @support_reply.errors.full_messages
      @support_replies = @support_request.support_replies.order(:created_at)
      render 'support_requests/show'
    end
  end

  private

    def support_reply_params
      params.require(:support_reply).permit(:content, :support_request_id)
    end

end
