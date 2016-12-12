module DebtsService

  def self.process_requests(investor_request)
    borrowers_requests = RequestsService.find_appropriate_borrower_requests(investor_request)
    borrowers_requests.each do |borrower_request|
      DebtsService.create_loan(investor_request, borrower_request)
      break if investor_request.completed?
    end
  end

  def self.create_loan(investor_request, borrower_request)
    amount_for_loan = DebtsService.amount_for_loan(investor_request, borrower_request)
    debt = Debt.new(borrower_request: borrower_request, status: :active)
    investor_request.debts << debt
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
    investor_amount = investor_request.amount.dollars
    borrower_amount = borrower_request.amount.dollars
    [borrower_amount, investor_amount].min
  end

end