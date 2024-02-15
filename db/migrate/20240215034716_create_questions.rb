class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :question_text, null: false
      t.integer :correct_answer, null: false
      t.integer :year, null: false
      t.string :subject, null: false

      t.timestamps
    end
  end
end
