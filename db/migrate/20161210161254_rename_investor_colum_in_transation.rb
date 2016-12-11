class RenameInvestorColumInTransation < ActiveRecord::Migration[5.0]
  def change
    rename_column :ardis_transactions, :inverstor_id, :investor_id
  end
end
