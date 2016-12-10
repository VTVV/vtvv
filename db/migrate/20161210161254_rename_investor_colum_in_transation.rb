class RenameInvestorColumInTransation < ActiveRecord::Migration[5.0]
  def change
    rename_column :transactions, :inverstor_id, :investor_id
  end
end
