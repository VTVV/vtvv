class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :borrower_id
      t.integer :inverstor_id
      t.integer :type
      t.decimal :amount

      t.timestamps
    end
  end
end
