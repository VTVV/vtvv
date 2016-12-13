class RenameTransactionToArdisTransaction < ActiveRecord::Migration[5.0]
  def change
    rename_table :transactions, :ardis_transactions
  end
end
