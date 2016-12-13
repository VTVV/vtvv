class ChangeTransactionTypeToKind < ActiveRecord::Migration[5.0]
  def change
    rename_column :ardis_transactions, :type, :kind
  end
end
