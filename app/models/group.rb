class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :tasks, dependent: :destroy

  
  validates :name, presence: true, uniqueness: true
  validates :users, 
  length: { 
      minimum: 2,
      message: 'は2人以上を選択してください' 
  }
end
