class ExchangeDates < ActiveRecord::Migration[5.0]
  def change
    remove_column :borrower_requests, :due_date, :datetime
    remove_column :investor_requests, :duration, :integer
    add_column :borrower_requests, :duration, :integer
    add_column :investor_requests, :due_date, :datetime
  end
end
