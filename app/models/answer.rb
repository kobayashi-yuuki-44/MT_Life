class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  belongs_to :selected_option, class_name: 'Option', foreign_key: 'selected_option_id'

  before_save :set_is_correct

  private

  def set_is_correct
    user_selected_positions = self.question.options.where(id: self.selected_option_ids).pluck(:position)
    correct_positions = self.question.correct_option_positions
    self.is_correct = (user_selected_positions.sort == correct_positions.sort)
  end
end
