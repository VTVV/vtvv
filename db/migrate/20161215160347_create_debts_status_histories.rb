class CreateDebtsStatusHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :debts_status_histories do |t|
      t.integer :status
      t.references :debt, foreign_key: true

      t.timestamps
    end
  end
end
