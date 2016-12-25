class Admin::UserInfoController < Admin::ApplicationController

  def show
    @user = User.find(params[:id])
  end

end