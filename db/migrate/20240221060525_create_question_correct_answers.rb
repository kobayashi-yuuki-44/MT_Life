class CreateQuestionCorrectAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :question_correct_answers do |t|
      t.references :question, null: false, foreign_key: true
      t.integer :correct_answer

      t.timestamps
    end
  end
end
