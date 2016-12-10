module RequestsService

  def self.find_appropriate_borrower_requests(investor_request)
    if investor_request.due_date < DateTime.now
      []
    else
      lowest_cs = investor_request.from_rate
      highest_cs = investor_request.to_rate
      BorrowerRequest
          .select do |br|
            ### by ROT
            cs = br.account.credit_score
            cs_ok = (cs >= lowest_cs && cs <= highest_cs)
            ### by status
            status_ok = (br.status == 'pending')
            ### by date
            duration_ok = br.duration < ((investor_request.due_date - DateTime.now) / 1.week)
            status_ok && cs_ok && duration_ok
          end
          .order('amount_cents DESC')
    end
  end

end