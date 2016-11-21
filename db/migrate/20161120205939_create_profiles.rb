class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.integer :sex
      t.string :home_phone
      t.string :mobile_phone
      t.string :company_name
      t.string :job_position
      t.string :nationality
      t.string :credit_number
      t.string :address
      t.string :passport
      t.decimal :salary
      t.string :salary_document
      t.integer :family_status
      t.date :birth_date

      t.timestamps
    end
  end
end
