module SetProfile
  extend ActiveSupport::Concern
  included do
  	before_action :set_profile, only: [:show, :update, :edit]
  end

  private
  def set_profile
    @profile = current_user.try(:profile) || Profile.new
  end
end