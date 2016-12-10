class CreateSystemScores < ActiveRecord::Migration[5.0]
  def change
    create_table :system_scores do |t|
      t.integer  :score_cents,    default: 0,     null: false
      t.string   :score_currency, default: 'USD', null: false

      t.timestamps
    end
  end
end
