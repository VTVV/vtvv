class CreateDebtsInvestorRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :debts_investor_requests do |t|
      t.references :debt, foreign_key: true
      t.references :investor_request, foreign_key: true

      t.timestamps
    end
  end
end
