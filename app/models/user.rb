class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  # validates :email, :password, presence: true
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  mount_uploader :image, ImageUploader

  has_many :tasks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

end
