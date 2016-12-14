class CreateFrequentlyAskedQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :frequently_asked_questions do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
