class HomeController < ApplicationController
  def show
    @profile = current_user.try(:profile) || Profile.new
  end
end
