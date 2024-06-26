class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def notify
    update(notification: true)
  end

  def clear_notification
    update(notification: false)
  end
end
