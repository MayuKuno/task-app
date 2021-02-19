class Notification < ApplicationRecord
  # default_scope->{order(created_at: :desc)}

  belongs_to :user
  belongs_to :task

  enum action: { warning: 1, expired: 2}
end
