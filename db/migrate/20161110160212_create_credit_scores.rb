class CreateCreditScores < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_scores do |t|
      t.references :user, foreign_key: true
      t.decimal :score
      t.integer :status

      t.timestamps
    end
  end
end
