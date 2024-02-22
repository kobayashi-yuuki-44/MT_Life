class ImageQuestion < ApplicationRecord
  belongs_to :question
  # ActiveStorageを使用して画像を扱う場合
  has_one_attached :image
end
