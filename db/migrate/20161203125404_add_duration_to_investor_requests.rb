class AddDurationToInvestorRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :investor_requests, :duration, :integer
  end
end
