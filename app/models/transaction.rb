class Transaction < ApplicationRecord

  COMMISSION_PERCENT = 0.05

  monetize :amount_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}

  enum kind: [:refill, :withdrawal, :loan, :refund, :commission]

  after_save :process_money

  belongs_to :borrower, class_name: 'Account', optional: true
  belongs_to :investor, class_name: 'Account', optional: true

  private

  def process_money
    case kind
    when 'refill'
      refill
    when 'withdrawal'
      withdrawal
    when 'loan'
    when 'refund'
    when 'commission'
      get_commission
    end
  end

  def get_commission
    system = SystemScore.instance
    current_score = system.score.amount
    updated_score = current_score + amount.amount
    SystemScore.instance.update(score: Money.new(updated_score * 100, 'USD'))
  end

  def refill
    transaction do
      account = (borrower or investor)
      amount_to_refill = amount.amount * (1 - COMMISSION_PERCENT)
      commission_amount = amount.amount * COMMISSION_PERCENT
      current_account_score = account.score.amount
      updated_account_score = current_account_score + amount_to_refill
      account.update(score: Money.new(updated_account_score * 100, 'USD'))
      Transaction.create(kind: :commission, amount: commission_amount)
    end
  end

  def withdrawal
    transaction do
      account = (borrower or investor)
      amount_to_refill = amount.amount * (1 - COMMISSION_PERCENT)
      commission_amount = amount.amount * COMMISSION_PERCENT
      current_account_score = account.score.amount
      updated_account_score = current_account_score - amount_to_refill
      account.update(score: Money.new(updated_account_score * 100, 'USD'))
      Transaction.create(kind: :commission, amount: commission_amount)
    end
  end
end
