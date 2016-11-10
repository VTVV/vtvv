class CreateBorrowerRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :borrower_requests do |t|
      t.references :user, foreign_key: true
      t.decimal :amount
      t.datetime :due_date

      t.timestamps
    end
  end
end
