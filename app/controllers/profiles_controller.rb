class ProfilesController < ApplicationController
  include ProfileData
  before_action :authorize_user

  def edit
  end

  def update
    if current_profile.update(profile_params)
      redirect_to edit_profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end
  private
  def authorize_user
    unless current_user.present? && (current_user.account.borrower? || current_user.account.investor?)
      redirect_back(fallback_location: root_path)
    end
  end
end
