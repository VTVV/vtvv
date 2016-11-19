class CreateInvestorRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :investor_requests do |t|
      t.references :user, foreign_key: true
      t.decimal :amount
      t.decimal :from_rate
      t.decimal :to_rate

      t.timestamps
    end
  end
end
