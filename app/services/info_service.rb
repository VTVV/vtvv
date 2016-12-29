module InfoService

  COLLECT_DOLLARS = Proc.new { |sum, t| sum += t.amount.dollars; sum }

  def self.get_requests(from_date, due_date)
    investor_requests = InvestorRequest.where( created_at: from_date..due_date)
    borrower_requests = BorrowerRequest.where( created_at: from_date..due_date)
    [investor_requests, borrower_requests]
  end

  def self.get_money_info(from_date, due_date)
    money_borrowed, money_earned, money_refunded, money_invested = 0, 0, 0, 0
    Account.all.each do |a|
        if a.account_type == 'borrower'
          account_money_stat = get_borrower_money_stats(a, from_date, due_date)
          money_borrowed += account_money_stat[:money_borrowed]
          money_refunded += account_money_stat[:money_refunded]
        end

        if a.account_type == 'investor'
          account_money_stat = get_investor_money_stats(a, from_date, due_date)
          money_invested += account_money_stat[:money_invested]
          money_earned += account_money_stat[:money_earned]
        end
    end


    money_refilled = ArdisTransaction
                         .where(kind: :refill)
                         .where(created_at: from_date..due_date)
                         .reduce(0, &COLLECT_DOLLARS)

    money_commission = ArdisTransaction
                          .where(kind: :commission)
                          .where(created_at: from_date..due_date)
                          .reduce(0, &COLLECT_DOLLARS)

    {money_invested: money_invested,
     money_earned: money_earned,
     money_borrowed: money_borrowed,
     money_refunded: money_refunded,
     money_refilled: money_refilled,
     money_commission: money_commission
    }

  end

  def self.get_common_money_stats(from_date, due_date)
    refilled = ArdisTransaction
                 .where(kind: :refill)
                 .where(created_at: from_date..due_date)
                 .reduce(0, &COLLECT_DOLLARS)
    withdrawal = ArdisTransaction
                   .where(kind: :withdrawal)
                   .where(created_at: from_date..due_date)
                   .reduce(0, &COLLECT_DOLLARS)
    loaned = ArdisTransaction
               .where(kind: :loan)
               .where(created_at: from_date..due_date)
               .reduce(0, &COLLECT_DOLLARS)
    refunded = ArdisTransaction
                 .where(kind: :refund)
                 .where(created_at: from_date..due_date)
                 .reduce(0, &COLLECT_DOLLARS)
    commission = ArdisTransaction
                   .where(kind: :commission)
                   .where(created_at: from_date..due_date)
                   .reduce(0, &COLLECT_DOLLARS)
    {
      refill: refilled,
      withdrawal: withdrawal,
      loan: loaned,
      refund: refunded,
      commission: commission
    }
  end


  def self.get_investor_money_stats(investor, from_date, due_date)
    money_invested = ArdisTransaction
                        .where(investor_id: investor.id)
                        .where(kind: :loan)
                        .where(created_at: from_date..due_date)
                        .reduce(0, &COLLECT_DOLLARS)
    money_earned = ArdisTransaction
                      .where(investor_id: investor.id)
                      .where(kind: :refund)
                      .where(created_at: from_date..due_date)
                      .reduce(0, &COLLECT_DOLLARS)
    money_withdrawn = ArdisTransaction
                        .where(investor_id: investor.id)
                        .where(kind: :withdrawal)
                        .where(created_at: from_date..due_date)
                        .reduce(0, &COLLECT_DOLLARS)
    money_refilled = ArdisTransaction
                       .where(investor_id: investor.id)
                       .where(kind: :refill)
                       .where(created_at: from_date..due_date)
                       .reduce(0, &COLLECT_DOLLARS)
    {
      invest: money_invested,
      earn: money_earned,
      withdrawal: money_withdrawn,
      refill: money_refilled
    }
  end

  def self.get_borrower_money_stats(borrower, from_date, due_date)
    money_borrowed = ArdisTransaction
                        .where(borrower_id: borrower.id)
                        .where(kind: :loan)
                        .where(created_at: from_date..due_date)
                        .reduce(0, &COLLECT_DOLLARS)
    money_refunded = ArdisTransaction
                        .where(borrower_id: borrower.id)
                        .where(kind: :refund)
                        .where(created_at: from_date..due_date)
                        .reduce(0, &COLLECT_DOLLARS)
    money_withdrawn = ArdisTransaction
                       .where(borrower_id: borrower.id)
                       .where(kind: :withdrawal)
                       .where(created_at: from_date..due_date)
                       .reduce(0, &COLLECT_DOLLARS)
    money_refilled = ArdisTransaction
                       .where(borrower_id: borrower.id)
                       .where(kind: :refill)
                       .where(created_at: from_date..due_date)
                       .reduce(0, &COLLECT_DOLLARS)

    {
      loan: money_borrowed,
      refund: money_refunded,
      withdrawal: money_withdrawn,
      refill: money_refilled
    }
  end

  def self.get_borrower_requests_stats(borrower, from_date, due_date)
    all = BorrowerRequest
            .where(account: borrower)
            .where(created_at: from_date..due_date)
    pending = BorrowerRequest
                .where(account: borrower)
                .where(status: :pending)
                .where(created_at: from_date..due_date)
    active = BorrowerRequest
                .where(account: borrower)
                .where(status: :active)
                .where(created_at: from_date..due_date)
    completed = BorrowerRequest
                .where(account: borrower)
                .where(status: :completed)
                .where(created_at: from_date..due_date)
    overdue = BorrowerRequest
                .where(account: borrower)
                .where(status: :overdue)
                .where(created_at: from_date..due_date)
    {
      all: all,
      pending: pending,
      active: active,
      completed: completed,
      overdue: overdue
    }
  end

  def self.get_investor_requests_stats(investor, from_date, due_date)
    all = InvestorRequest
            .where(account: investor)
            .where(created_at: from_date..due_date)
    pending = InvestorRequest
                .where(account: investor)
                .where(status: :pending)
                .where(created_at: from_date..due_date)
    active = InvestorRequest
               .where(account: investor)
               .where(status: :active)
               .where(created_at: from_date..due_date)
    completed = InvestorRequest
                  .where(account: investor)
                  .where(status: :completed)
                  .where(created_at: from_date..due_date)
    overdue = InvestorRequest
                .where(account: investor)
                .where(status: :overdue)
                .where(created_at: from_date..due_date)
    {
      all: all,
      pending: pending,
      active: active,
      completed: completed,
      overdue: overdue
    }
  end
end