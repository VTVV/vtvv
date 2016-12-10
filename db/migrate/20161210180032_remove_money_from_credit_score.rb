class RemoveMoneyFromCreditScore < ActiveRecord::Migration[5.0]
  def change
    remove_monetize :credit_scores, :score
    add_column :credit_scores, :score, :decimal
  end
end
