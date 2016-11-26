class BuildingProfilesController < ApplicationController

  include Wicked::Wizard
  include ProfileData

  steps :choose_account, :build_profile

  def show
    @user = current_user
    case step
      when :choose_account
      when :build_profile
        @profile = current_user.profile
    end
    render_wizard
  end

  def update
    @user = current_user
    case step
      when :choose_account
        account = Account.new account_type: params[:user][:account_type].to_i, user_id: @user.id
        profile = Profile.new user_id: @user.id
        unless account.save && profile.save
          raise StandardError
        end
      when :build_profile
        @profile = current_user.profile
        unless @profile.update(profile_params)
          raise StandardError
        end
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
