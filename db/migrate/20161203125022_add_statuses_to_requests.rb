class AddStatusesToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :investor_requests, :status, :integer
    add_column :borrower_requests, :status, :integer
  end
end
