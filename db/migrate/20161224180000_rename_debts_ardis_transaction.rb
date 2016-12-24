class RenameDebtsArdisTransaction < ActiveRecord::Migration[5.0]
  def change
    rename_table :debts_ardis_transactions, :ardis_transactions_debts
  end
end
