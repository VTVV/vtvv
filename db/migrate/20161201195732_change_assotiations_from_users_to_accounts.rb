class ChangeAssotiationsFromUsersToAccounts < ActiveRecord::Migration[5.0]
  def change

    remove_reference :credit_scores, :user, index: true
    remove_reference :borrower_requests, :user, index: true
    remove_reference :investor_requests, :user, index: true

    add_reference :credit_scores, :account, index: true
    add_reference :borrower_requests, :account, index: true
    add_reference :investor_requests, :account, index: true

  end

end
