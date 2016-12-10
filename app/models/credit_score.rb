class CreditScore < ApplicationRecord

  enum status: [:pending, :approved]
  
  belongs_to :account
end
