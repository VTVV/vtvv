module DebtsService

  def self.process_investor_requests
    InvestorRequest.where(status: :active).order(created_at: :asc).each do |request|
      DebtsService.process_requests(request)
    end
  end

  def self.process_requests(investor_request)
    borrowers_requests = RequestsService.find_appropriate_borrower_requests(investor_request)
    borrowers_requests.each do |borrower_request|
      DebtsService.create_loan(investor_request, borrower_request)
      break if investor_request.completed?
    end
  end

  def self.create_loan(investor_request, borrower_request)
    amount_for_loan = DebtsService.amount_for_loan(investor_request, borrower_request)
    debt = Debt.find_or_initialize_by(borrower_request: borrower_request,
                                      investor_request: investor_request,
                                      status: :active)
    transaction = ArdisTransaction.new(kind: :loan,
                                       amount: amount_for_loan,
                                       borrower: borrower_request.account,
                                       investor: investor_request.account)
    if transaction.valid?
      debt.ardis_transactions << transaction
      debt.save
    else
      'Sorry, can not create loan. Account score is not enough.'
    end
  end

  def self.amount_for_loan(investor_request, borrower_request)
    investor_amount = investor_request.amount_to_complete
    borrower_amount = borrower_request.amount_to_complete
    [borrower_amount, investor_amount].min
  end


  def self.pay_off(account, amount)
    amount_remain = amount
    account
      .borrower_requests
      .where(status: :active)
      .order(created_at: :asc)
      .each do |request|
        break if amount_remain == 0
        request.debts.each do |debt|
          break if amount_remain == 0
          unless debt.status == 'filled'
            money_to_refund = debt.stats[:money_to_refund]
            amount_to_pay = [money_to_refund, amount_remain].min
            amount_remain -= amount_to_pay
            transaction = ArdisTransaction.create(borrower: debt.borrower_request.account,
                                                  investor: debt.investor_request.account,
                                                  kind: :refund,
                                                  amount: amount_to_pay)
            if transaction.valid?
              transaction.save
              debt.ardis_transactions << transaction
            end
          end
        end
      end
  end

end