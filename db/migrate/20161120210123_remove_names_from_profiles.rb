class RemoveNamesFromProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :accounts, :first_name, :string
    remove_column :accounts, :last_name, :string
  end
end
