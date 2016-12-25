class Admin::TimeTravelsController < Admin::ApplicationController


  def new
    Timecop.scale(1)
    @date = Date.new
  end

  def create
    Timecop.travel(params[:travel][:date])
    redirect_to new_admin_time_travels_path
  end

end