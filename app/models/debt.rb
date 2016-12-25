class Debt < ApplicationRecord

  enum status: [:active, :overdue, :closed]

  belongs_to :borrower_request
  belongs_to :investor_request
  has_many :debts_status_histories
  has_and_belongs_to_many :ardis_transactions

  after_save :try_update_status
  after_save :update_requests_statuses
  after_save :set_history

  def stats
    {
        money_borrowed: money_borrowed,
        money_to_refund: money_to_refund,
        money_refunded: money_refunded,
        status: status.to_s
    }
  end

  def try_update_status
    current_stats = stats
    unless status == 'closed'
      if weeks_difference - borrower_request.duration >= 0
        update(status: Debt.statuses[:overdue])
      end
      if current_stats[:money_to_refund] <= current_stats[:money_refunded]
        update(status: Debt.statuses[:closed])
        borrower_request.update(status: BorrowerRequest.statuses[:completed])
        investor_request.update(status: InvestorRequest.statuses[:completed])
      end
    end
  end

  def map_money
    lambda { |sum, t| sum += t.amount.dollars; sum }
  end

  def money_borrowed
    ardis_transactions.where(kind: :loan).reduce(0,&map_money)
  end

  def money_to_refund
    money_borrowed * (1 + borrower_request.credit_percentage + penalty)
  end

  def money_refunded
    ardis_transactions.where(kind: :refund).reduce(0,&map_money)
  end

  def weeks_difference
    (DateTime.now - self.created_at.to_datetime) / 1.week
  end

  def penalty
    # penalty in % of amount
    if weeks_difference - borrower_request.duration > 0
      (weeks_difference - borrower_request.duration) * 0.02
    else
      0
    end
  end

  def update_requests_statuses
    borrower_request.update(status: BorrowerRequest.statuses[:active])
    investor_request.update(status: InvestorRequest.statuses[:active])
  end

  def set_history
    unless debts_status_histories.any?
      dsh = DebtsStatusHistory.create(status: status)
      self.debts_status_histories << dsh
    else
      unless debts_status_histories.last.status == status
        dsh = DebtsStatusHistory.create(status: status)
        self.debts_status_histories << dsh
      end
    end
  end

end
