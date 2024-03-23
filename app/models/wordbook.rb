class Wordbook < ApplicationRecord
  belongs_to :user
  has_many :words, dependent: :destroy

  validates :collection, presence: true
end
