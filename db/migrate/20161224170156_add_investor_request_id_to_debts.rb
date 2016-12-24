class AddInvestorRequestIdToDebts < ActiveRecord::Migration[5.0]
  def change
    add_column :debts, :investor_request_id, :integer
    add_foreign_key :debts, :investor_requests, column: :investor_request_id
  end
end
