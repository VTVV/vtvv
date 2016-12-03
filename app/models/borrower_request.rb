class BorrowerRequest < ApplicationRecord
  belongs_to :account

  validates :amount, presence: true, numericality: {greater_than: 0}
  validates :due_date, presence: true

  enum status: [:pending, :performed, :rejected]
end
