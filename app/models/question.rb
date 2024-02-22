class Question < ApplicationRecord
  has_many :options
  has_one :image_question
  has_many :answers
  has_many :question_correct_answers
end
