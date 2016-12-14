class Borrower::ApplicationController < ApplicationController

  before_action :authorize_user

  private

    def authorize_user
      unless current_user.present? && current_user.account.borrower?
        not_found
      end
    end

end