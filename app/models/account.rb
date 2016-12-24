class Account < ApplicationRecord
  belongs_to :user
  has_one :credit_score
  has_many :borrower_requests
  has_many :investor_requests
  has_many :ardis_transactions
  has_one :profile, through: :user
  enum account_type: [:borrower, :investor, :admin, :underwriter, :support]

  monetize :score_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}

  scope :active, -> {where active: true}
  scope :nonactive, -> {where active: false}

  def borrower_or_investor?
    borrower? || investor?
  end
end
