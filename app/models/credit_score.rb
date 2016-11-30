class CreditScore < ApplicationRecord
  belongs_to :user

  enum status: [:pending, :approved]
end
