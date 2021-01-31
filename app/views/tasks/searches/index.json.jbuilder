json.array! @tasks do |task|
  json.id task.id
  json.taskname task.taskname
  json.deadline task.deadline
  json.created_at task.created_at
  json.status task.status
  json.user_id task.user.id
  json.username task.user.username
  json.labels task.labels
  json.user_sign_in current_user

end