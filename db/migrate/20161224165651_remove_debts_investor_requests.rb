class RemoveDebtsInvestorRequests < ActiveRecord::Migration[5.0]
  def change
    drop_table :debts_investor_requests
  end
end
