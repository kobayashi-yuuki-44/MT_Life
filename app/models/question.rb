class Question < ApplicationRecord
  has_many :options
  has_one :image_question
  has_many :answers
  has_many :question_correct_answers
  has_many :correct_answers, through: :question_correct_answers, source: :option
  has_one :memo, dependent: :destroy

  def correct_option_positions
    options.where(id: question_correct_answers.pluck(:correct_answer)).pluck(:position)
  end

  def correct_answer?(user_selected_option_ids)
    user_selected_positions = options.where(id: user_selected_option_ids).pluck(:position)
    correct_positions = question_correct_answers.pluck(:correct_answer)
    user_selected_positions.sort == correct_positions.sort
  end
end
