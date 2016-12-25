class Admin::TimeTravelsController < Admin::ApplicationController


  def new
    Timecop.scale(1)
    @date = Date.new
  end

  def create

    date = params[:travel][:date]

    unless date < DateTime.now
      Timecop.travel(date)
    end

    redirect_to new_admin_time_travels_path
  end

end