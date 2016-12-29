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
    DebtsService.process_investor_requests
    DebtsService.update_statuses
    RotService.update_borrowers_scores

    redirect_to new_admin_time_travels_path
  end

end