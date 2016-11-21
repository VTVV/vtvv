class Account < ApplicationRecord
  belongs_to :user

  enum account_type: [:borrower, :investor, :admin, :underwriter, :support]
end
