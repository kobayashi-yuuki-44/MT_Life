class Post < ApplicationRecord
  belongs_to :user

  validates :post_content, presence: true
end
