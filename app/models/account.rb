class Account < ApplicationRecord
  belongs_to :user
  has_one :credit_score
  enum account_type: [:borrower, :investor, :admin, :underwriter, :support]
end
