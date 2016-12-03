class Borrower::ApplicationController < ApplicationController

  before_action :authorize_user

  private

    def authorize_user
      unless current_user.present? && current_user.account.borrower?
        redirect_back(fallback_location: root_path)
      end
    end

end