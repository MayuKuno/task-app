json.array! @tasks do |task|
  json.id task.id
  json.taskname task.taskname
  json.description task.description
  json.user_id task.user_id
  json.username task.username
  json.user_sign_in task.current_user
  
end