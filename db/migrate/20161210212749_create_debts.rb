class CreateDebts < ActiveRecord::Migration[5.0]
  def change
    create_table :debts do |t|
      t.integer :status
      t.references :borrower_request, foreign_key: true

      t.timestamps
    end
  end
end
