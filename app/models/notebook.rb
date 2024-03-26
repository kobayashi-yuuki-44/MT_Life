class Notebook < ApplicationRecord
  belongs_to :user
  has_many :pages, dependent: :destroy

  validates :title, presence: true
end