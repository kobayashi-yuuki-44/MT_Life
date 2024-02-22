class RemoveCorrectAnswerFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :correct_answer, :integer
  end
end
