class Admin::InvestorsStatsController < ApplicationController
  def index
    @investors = Account
                   .where(account_type: :investor)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(7)
  end

  def show
    @investor = Account.find(params[:id])
    @from = params.dig(:investor,:from) || Date.today - 5.year
    @to = params.dig(:investor,:to) || Date.today
    @common_stats = InfoService.get_investor_money_stats(@investor, @from, @to)
    @requests_stats = InfoService.get_investor_requests_stats(@investor, @from, @to)
  end
end
