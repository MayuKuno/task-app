class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :task

  enum action: { warning: 1, expired: 2}
end
