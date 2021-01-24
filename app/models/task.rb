class Task < ApplicationRecord
  validates :taskname, presence: true
  enum priority: {
    low: 0,
    middle: 1,
    high: 2,
    }
  enum status: {
    waiting: 0,
    started: 1,
    completed: 2,
    }
end
