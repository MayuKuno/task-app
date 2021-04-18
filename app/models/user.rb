class User < ApplicationRecord
  has_secure_password
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save { email.downcase! }

  VALID_USERNAME_REGEX = /\A[a-z0-9]+\z/i
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :username, uniqueness: { case_sensitive: false } ,presence: true, length: {maximum: 10}, format: { with: VALID_USERNAME_REGEX }


  mount_uploader :image, ImageUploader

  has_many :tasks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  def to_param
    username
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com',username: 'guest', admin: false) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end


end
