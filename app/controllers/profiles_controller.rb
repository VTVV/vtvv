class ProfilesController < ApplicationController
  include ProfileData

  def edit
  end

  def update
    if current_profile.update(profile_params)
      redirect_to profile_path(current_profile), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end
end
