class DirectMessage < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  after_create_commit { DirectMessageBroadcastJob.perform_later self }

  validates :message_content, presence: true
end
