json.array! @tasks do |task|
  json.id task.id
  json.taskname task.taskname
  json.deadline task.deadline
  json.created_at task.created_at
  json.status task.status
  json.user_id task.user.id
  json.username task.user.username
  json.labels task.labels
    
  # task.labels do |label|
  #   json.colors task.label.color
  # end


end