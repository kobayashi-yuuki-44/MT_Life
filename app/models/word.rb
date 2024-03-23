class Word < ApplicationRecord
  belongs_to :wordbook

  validates :term, :definition, presence: true
end
