class InvestorRequest < ApplicationRecord
  belongs_to :account

  monetize :amount_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}
  validates :from_rate, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 100}
  validates :to_rate, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 100}
  validates :duration, presence: true, numericality: {greater_than: 0}

  enum status: [:pending, :performed, :rejected]
end
