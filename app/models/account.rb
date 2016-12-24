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

  def update_debts_statuses
    borrower_requests.where(status: :active).each do |request|
      request.debts.where.not(status: :closed).each do |debt|
        debt.try_update_status
      end
    end
  end
end
