class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  private

    def current_profile
      current_user.try(:profile) || Profile.new
    end

    def current_account
      current_user.try(:account)
    end
    
end
