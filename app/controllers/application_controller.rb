class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_profile
  helper_method :current_account

  private

    def current_profile
      current_user.try(:profile) || Profile.new
    end

    def current_account
      current_user.accounts.first
    end

end
