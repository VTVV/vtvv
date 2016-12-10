module RequestsService

  def find_appropriate_borrower_requests(investor_request)
    BorrowerRequest
        .where(status: :pending)
        .select do |br|
          true
        end
  end

end