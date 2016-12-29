class Admin::BorrowersStatsController < ApplicationController
  def index
    @borrowers = Account
                   .where(account_type: :borrower)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(7)
  end

  def show
    @borrower = Account.find(params[:id])
    @from = params.dig(:borrower,:from) || Date.today - 5.year
    @to = params.dig(:borrower,:to) || Date.today
    @trusted_score = @borrower.credit_score.score.round(2) * 100
    @common_stats = InfoService.get_borrower_money_stats(@borrower, @from, @to)
    @requests_stats = InfoService.get_borrower_requests_stats(@borrower, @from, @to)
  end
end
