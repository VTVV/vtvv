class RemovePassportAndSalaryDocumentFromProfile < ActiveRecord::Migration[5.0]
  def change
      remove_column :profiles, :salary_document, :string
      remove_column :profiles, :passport, :string
  end
end
