class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.references :account, foreign_key: true
      t.text :note, default: '', null: false
      t.string :file, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
