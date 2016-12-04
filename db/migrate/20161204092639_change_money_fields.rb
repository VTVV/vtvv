class ChangeMoneyFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :borrower_requests, :amount, :decimal
    add_monetize :borrower_requests, :amount

    remove_column :investor_requests, :amount, :decimal
    add_monetize :investor_requests, :amount

    remove_column :credit_scores, :score, :decimal
    add_monetize :credit_scores, :score

    remove_column :transactions, :amount, :decimal
    add_monetize :transactions, :amount

    add_monetize :accounts, :score
  end
end
