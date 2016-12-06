class BuildingProfilesController < ApplicationController

  include Wicked::Wizard
  include ProfileData

  steps :choose_account, :build_profile

  before_filter :check_if_many_accounts

  def show
    @user = current_user
    case step
      when :choose_account
        if @user.accounts.count == 1
          Account.create(user_id: @user.id, 
            account_type: (current_account.account_type == 'investor')? 'borrower' : 'investor')
          redirect_to building_profile_path(:build_profile) 
        end
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

  private 
  def check_if_many_accounts
    unless current_user and current_user.accounts.count < 2
      raise StandardError
    end
  end

end
