class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  helper_method :current_profile
  helper_method :current_account

  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_found

  before_action :check_if_has_account

  def not_found
    redirect_back fallback_location: root_path, :flash => { :error => "Insufficient rights!" }
  end

  private

    def authenticate_inviter!
      unless current_account.admin?
        not_found
      end
    end

    def current_profile
      @current_profile ||= current_user.try(:profile) || Profile.new
    end

    def current_account
      @current_account ||= (current_user.try(:accounts).present?) &&
      (current_user.accounts.active.first ||
      (current_user.accounts.first.update_attributes(active: true) && current_user.accounts.active.first))
    end

    def after_sign_out_path_for(resource_or_scope)
      root_path
    end

    def check_if_has_account
      if current_user &&
        current_user.accounts.count == 0 &&
        request.env['PATH_INFO'] != building_profile_path(:choose_account) &&
        request.env['PATH_INFO'] != destroy_user_session_path
        redirect_to building_profile_path(:choose_account)
      end
    end

end
