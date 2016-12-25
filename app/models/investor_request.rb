class InvestorRequest < ApplicationRecord

  monetize :amount_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}

  enum status: [:pending, :active, :completed, :rejected]

  belongs_to :account
  has_many :debts

  validates :from_rate, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 100}
  validates :to_rate, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 100}
  validates :due_date, presence: true
  validate :validate_due_date

  after_save :check_status

  def pending?
    status == 'pending'
  end

  def active?
    status == 'active'
  end

  def completed?
    status == 'completed'
  end

  def amount_to_complete
    beginning_amount = self.amount
    invested_amount = self.debts.reduce(0) do |sum, debt|
      money = debt.ardis_transactions.where(kind: :loan).reduce(0) do |loan_sum, loan|
        loan_sum += loan.amount
        loan_sum
      end
      sum += money
      sum
    end
    beginning_amount - invested_amount
  end

  private

  def check_status
    money_borrowed = debts.reduce(0) do |sum, debt|
                       sum += debt.stats[:money_borrowed]
                       sum
    end
    if active? && (money_borrowed == amount.dollars)
      update(status: :completed)
    end
  end

  def validate_due_date
    if due_date
      if (due_date - DateTime.now) < 1.month
        errors.add(:due_date, "should be later than 1 month.")
      end
    end
  end
end
