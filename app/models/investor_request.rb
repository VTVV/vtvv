class InvestorRequest < ApplicationRecord
  belongs_to :account

  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :from_rate, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 100}
  validates :to_rate, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 100}
  validates :duration, presence: true, numericality: {greater_than: 0}

  enum status: [:pending, :performed, :rejected]
end
