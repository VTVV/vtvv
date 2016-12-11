class CreateSupportRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :support_requests do |t|
      t.text :content
      t.references :user
      t.timestamps
    end
  end
end
