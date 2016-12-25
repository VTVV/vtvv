module RequestsService

  def self.find_appropriate_borrower_requests(investor_request)
    if investor_request.due_date < DateTime.now
      []
    else
      lowest_cs = investor_request.from_rate.to_f / 100
      highest_cs = investor_request.to_rate.to_f / 100
      ids = BorrowerRequest
                .select do |br|
                  ### by ROT
                  cs = br.account.credit_score.score
                  cs_ok = (cs >= lowest_cs && cs <= highest_cs)
                  ### by status
                  status_ok = (br.status == 'pending' or br.status == 'active')
                  ### by date
                  duration_ok = br.duration < ((investor_request.due_date - DateTime.now) / 1.week)
                  zero_complete_amount = (br.amount_to_complete == 0)
                  status_ok && cs_ok && duration_ok && !zero_complete_amount
                end
      BorrowerRequest.where(id: ids).order('created_at DESC')
    end
  end

  def self.incomplete_investor_requests
    InvestorRequest.where(status: [:pending, :active])
  end

end