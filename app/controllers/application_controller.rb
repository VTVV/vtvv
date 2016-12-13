class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  helper_method :current_profile
  helper_method :current_account

  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_found

  def not_found
    render file: "errors/not_found.html.slim", format: :html, status: :not_found
  end

  private

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


end
