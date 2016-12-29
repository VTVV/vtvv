namespace :debts do
  task process_investor_requests: :environment do
    DebtsService.process_investor_requests
  end

  task update_borrowers_scores: :environment do
    RotService.update_borrowers_scores
  end
end
