class InvestorRequest < ApplicationRecord
  belongs_to :account

  monetize :amount_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}
  validates :from_rate, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 100}
  validates :to_rate, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 100}
  validates :due_date, presence: true
  validate :validate_due_date


  enum status: [:pending, :performed, :rejected]

  private

  def validate_due_date
    if due_date
      if (due_date - DateTime.now) < 1.month
        errors.add(:due_date, "should be later than 1 month.")
      end
    end
  end
end
