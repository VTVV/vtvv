class CreditScore < ApplicationRecord
  belongs_to :account

  enum status: [:pending, :approved]
  monetize :score_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}
end
