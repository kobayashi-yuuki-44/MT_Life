class Option < ApplicationRecord
  belongs_to :question
  has_many :answers, foreign_key: 'selected_option_id'
end
