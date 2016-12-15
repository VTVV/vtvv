class ProfilesController < ApplicationController
  include ProfileData
  include Authorizable

  def edit
  end

  def update
    if current_profile.update(profile_params)
      redirect_to edit_profile_path, notice: 'Profile has been successfully updated.'
    else
      render :edit
    end
  end
  private
    def entity
      @profile = current_profile
    end

    def model
      Profile
    end
end
