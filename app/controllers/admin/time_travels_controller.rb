class Admin::TimeTravelsController < Admin::ApplicationController


  def new
    Timecop.scale(1)
    @date = Date.new
  end

  def create

  end

  def show

  end

  def travel
    # TODO
    Timecop.travel(@date)

  end

  def travel_back
    # TODO
  end
end