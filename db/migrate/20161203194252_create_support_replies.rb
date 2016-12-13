class CreateSupportReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :support_replies do |t|
      t.references :support_request
      t.references :user
      t.text :content
      t.timestamps
    end
  end
end
