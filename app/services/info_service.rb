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
    {money_invested: money_invested, money_earned: money_earned}
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
    {money_borrowed: money_borrowed, money_refunded: money_refunded}
  end
end