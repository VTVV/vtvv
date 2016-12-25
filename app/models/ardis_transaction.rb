class ArdisTransaction < ApplicationRecord

  COMMISSION_PERCENT = 0.05

  monetize :amount_cents, with_model_currency: :currency, :numericality => {:greater_than_or_equal_to => 0}

  enum kind: [:refill, :withdrawal, :loan, :refund, :commission]

  belongs_to :borrower, class_name: 'Account', optional: true
  belongs_to :investor, class_name: 'Account', optional: true
  has_and_belongs_to_many :debts

  validate :check_account_score

  after_create :process_money

  private

  def check_account_score
    case kind
    when 'withdrawal'
      check_score_for_withdrawal
    when 'loan'
      check_score_for_loan
    when 'refund'
      check_score_for_refund
    when 'commission'
      get_commission
    end
  end

  def check_score_for_withdrawal
    if borrower.score.dollars < amount.dollars
      errors.add(:amount, 'can not be less than account score.')
    end
  end

  def check_score_for_loan
    if investor.score.dollars < amount.dollars
      errors.add(:amount, 'can not be less than account score.')
    end
  end

  def check_score_for_refund
    if borrower.score.dollars < amount.dollars
      errors.add(:amount, 'can not be less than account score.')
    end
  end

  def process_money
    case kind
    when 'refill'
      refill
    when 'withdrawal'
      withdrawal
    when 'loan'
      loan
    when 'refund'
      refund
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
      ArdisTransaction.create(kind: :commission, amount: commission_amount)
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
      ArdisTransaction.create(kind: :commission, amount: commission_amount)
    end
  end

  def loan
    10.times { puts 'here' }
    transaction do
      amount_to_loan = amount.dollars
      borrower_amount = borrower.score.dollars
      updated_borrower_score = borrower_amount + amount_to_loan
      investor_amount = investor.score.dollars
      updated_investor_score = investor_amount - amount_to_loan
      borrower.update(score: Money.new(updated_borrower_score * 100, 'USD'))
      investor.update(score: Money.new(updated_investor_score * 100, 'USD'))
    end
  end


  def refund
    transaction do
      amount_to_refund = amount.dollars
      borrower_amount = borrower.score.dollars
      updated_borrower_score = borrower_amount - amount_to_refund
      investor_amount = investor.score.dollars
      updated_investor_score = investor_amount + amount_to_refund
      borrower.update(score: Money.new(updated_borrower_score * 100, 'USD'))
      investor.update(score: Money.new(updated_investor_score * 100, 'USD'))
    end
  end
end
