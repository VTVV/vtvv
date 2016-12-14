class Investor::DashboardsController < Investor::ApplicationController
  def show
    @investor_requests = current_account.investor_requests.first(10)
    @requests_count = current_account.investor_requests.count
    collect_dollars = Proc.new { |sum, t| sum += t.amount.dollars; sum }
    @money_invested = ArdisTransaction
                          .where(investor_id: current_account.id)
                          .where(kind: :loan)
                          .reduce(0, &collect_dollars)
    @money_earned = ArdisTransaction
                          .where(investor_id: current_account.id)
                          .where(kind: :refund)
                          .reduce(0, &collect_dollars)
  end
end
