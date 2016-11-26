class ProfilesController < ApplicationController
  include ProfileData
  include SetProfile 

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: 'Profile was successfully updated.' 
    else
      render :edit
    end
  end
end