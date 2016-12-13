class Debt < ApplicationRecord

  enum status: [:active, :filled, :overdue, :closed]

  belongs_to :borrower_request
  has_and_belongs_to_many :investor_requests
  has_and_belongs_to_many :ardis_transactions

  after_save :try_update_status

  def stats
    {
        money_borrowed: money_borrowed,
        money_to_refund: money_to_refund,
        money_refunded: money_refunded,
        status: status.to_s
    }
  end

  private

  def map_money
    lambda { |t| t.amount.dollars }
  end

  def money_borrowed
    ardis_transactions.where(status: :loan).map(&map_money)
  end

  def money_to_refund
    money_borrowed * (1 + borrower_request.credit_percentage)
  end

  def money_refunded
    ardis_transactions.where(status: :refund).map(&map_money)
  end

  def try_update_status
    ## TODO: check for fill and set appropriate status
  end

end
