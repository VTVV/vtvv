class BorrowerRequest < ApplicationRecord

  monetize :amount_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}

  enum status: [:pending, :active, :completed, :rejected, :overdue]

  validates :duration, presence: true, numericality: {greater_than_or_equal_to: 5}
  validates :amount, numericality: {greater_than_or_equal_to: 50}
  validate :integral_duration

  belongs_to :account
  has_many :debts

  def credit_percentage
    case amount.dollars
      when (50...100)
        0.3
      when(100...500)
        0.2
      when(500...3000)
        0.15
      else
        0.1
    end
  end

  def amount_to_complete
    beginning_amount = self.amount.dollars
    borrowed_amount = self.debts.reduce(0) do |sum, debt|
      money = debt.ardis_transactions.where(kind: :loan).reduce(0) do |loan_sum, loan|
        loan_sum += loan.amount.dollars
        loan_sum
      end
      sum += money
      sum
    end
    beginning_amount - borrowed_amount
  end

  private

  def integral_duration
    if duration - duration.floor > 0
      errors.add(:duration, "should be integral.")
    end
  end

end
