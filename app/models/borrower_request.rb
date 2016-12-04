class BorrowerRequest < ApplicationRecord
  belongs_to :account

  monetize :amount_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}
  validates :due_date, presence: true

  enum status: [:pending, :performed, :rejected]
end
