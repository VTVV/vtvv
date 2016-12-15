class AddAllowedToLoginToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :allowed_to_log_in, :boolean, default: true
  end
end
