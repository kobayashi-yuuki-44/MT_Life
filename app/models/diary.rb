class Diary < ApplicationRecord
  belongs_to :user

  validates :diaries_title, presence: true
  validates :diaries_content, presence: true
  validate :daily_limit, on: :create

  private

  def daily_limit
    if user.diaries.where(start_time: start_time.all_day).count >= 3
      errors.add(:base, '1日に作成できる日記は3つまでです。')
    end
  end
end
