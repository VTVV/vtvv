class ProfilesController < ApplicationController
  include ProfileData
  before_action :set_profile 
  
  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: 'Profile was successfully updated.' 
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = current_user.try(:profile) || Profile.new
  end
end