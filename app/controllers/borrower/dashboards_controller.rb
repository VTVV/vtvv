class Borrower::DashboardsController < Borrower::ApplicationController
  def show
    @borrower_requests = current_account.borrower_requests.first(10)
    @requests_count = current_account.borrower_requests.count
    collect_dollars = Proc.new { |sum, t| sum += t.amount.dollars; sum }
    @money_borrowed = ArdisTransaction
                          .where(borrower_id: current_account.id)
                          .where(kind: :loan)
                          .reduce(0, &collect_dollars)
    @money_refunded = ArdisTransaction
                          .where(borrower_id: current_account.id)
                          .where(kind: :refund)
                          .reduce(0, &collect_dollars)
    @money_to_refund = current_account.borrower_requests.where(status: [:active, :overdue]).reduce(0) do |sum, request|
      sum += request.debts.reduce(0) do |debt_sum, debt|
        debt_sum += debt.stats[:money_remain_to_refund]
        debt_sum
      end
      sum
    end
  end
end
