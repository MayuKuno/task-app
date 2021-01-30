class Task < ApplicationRecord
  validates :taskname, presence: true
  belongs_to :user, optional: true
  validates :user_id, presence: true
  has_many :task_labels
  has_many :labels, through: :task_labels
  enum priority: {
    low: 0,
    middle: 1,
    high: 2,
    }
  enum status: {
    Waiting: 0,
    Working: 1,
    Completed: 2,
    }

  def self.search(search)
    if search
      Task.where('taskname LIKE(?)', "%#{search}%")
    else
      Task.all
    end
  end

end
