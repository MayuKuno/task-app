class Task < ApplicationRecord
  validates :taskname, presence: true

end
