class CreditScore < ApplicationRecord
  belongs_to :account

  enum status: [:pending, :approved]
end
