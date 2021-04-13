class Task < ApplicationRecord
  include RankedModel
  include IdGenerator

  ranks :row_order

  validates :taskname,:user_id, presence: true

  belongs_to :user, optional: true
  has_one :notification, dependent: :destroy
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
  has_one_attached :image
  validate :avatar_type

  enum priority: { low: 0, middle: 1, high: 2 }
  enum status: { Waiting: 0, Working: 1, Completed: 2 }

  def self.search(search)
    if search
     Task.left_joins(:labels).where('taskname LIKE ? OR color LIKE ?', "%#{search}%", "%#{search}%").uniq
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

    if file == nil || file.content_type != "text/csv"
      return
    else
      CSV.foreach(file.path, headers: true) do |row|
        task = new
        task.attributes = row.to_hash.slice(*csv_attributes)
        task.save!
      end
    end
  end
  def late?
    deadline.in_time_zone < Date.current.in_time_zone
  end
  private
  def avatar_type
    if image.attached?
      if !image.blob.content_type.in?(%('image/jpeg image/png'))
        image.purge
        errors.add(:image, 'はjpegまたはpng形式でアップロードしてください')
      end
    end
  end

end
