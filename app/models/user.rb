class User < ApplicationRecord
  authenticates_with_sorcery!

  mount_uploader :avatar, AvatarUploader
  
  has_many :authentications, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :wordbooks, dependent: :destroy
  has_many :notebooks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :direct_messages
  has_many :rooms, through: :entries
  has_many :diaries, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validate :avatar_size_validation

  private

  def avatar_size_validation
    errors.add(:avatar, "should be less than 5MB") if avatar.size > 5.megabytes
  end
end
