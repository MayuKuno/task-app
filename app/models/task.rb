class Task < ApplicationRecord
  validates :taskname,:user_id, presence: true
  
  belongs_to :user, optional: true
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
  has_one_attached :image

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
      Task.where('taskname LIKE ?', "%#{search}%")
    else
      Task.include(:user).all
    end
  end


  def self.csv_attributes
    ["taskname", "description","priority","status","deadline", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr)}
      end
    end
  end



  def self.import(file)
    unless file
      return
    else
      CSV.foreach(file.path, headers: true) do |row|
        task = new
        task.attributes = row.to_hash.slice(*csv_attributes)
        task.save!
      end
    end
  end
end
