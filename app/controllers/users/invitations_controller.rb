class Users::InvitationsController < Devise::InvitationsController
  private

  def invite_resource
    super do |u|
      u.accounts << Account.new(account_type: params[:user][:account_type].to_i)
      u.profile = Profile.new
    end
  end

end
