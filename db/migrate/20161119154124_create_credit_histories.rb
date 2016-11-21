class CreateCreditHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_histories do |t|
      t.integer :number
      t.float :score

      t.timestamps
    end
  end
end
