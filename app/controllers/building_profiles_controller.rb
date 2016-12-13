class BuildingProfilesController < ApplicationController

  include Wicked::Wizard
  include ProfileData

  steps :choose_account, :build_profile

  def show
    @user = current_user
    case step
      when :choose_account
        authorize Account.new, :new?  
      when :build_profile
        @profile = current_profile
        authorize @profile, :edit?
    end
    render_wizard
  end

  def update
    @user = current_user
    case step
      when :choose_account
        authorize Account.new, :create?
        account = Account.create account_type: params[:user][:account_type].to_i, user_id: @user.id
        profile = Profile.create user_id: @user.id
      when :build_profile
        @profile = current_profile
        authorize @profile, :update?
        @profile.update(profile_params)
    end
    sign_in(@user, bypass: true)
    render_wizard @user
  end

  def finish_wizard_path
    root_path
    ### PUT YOUR PROFILE ROUTE HERE
    ### user_path(current_user)
  end

end
