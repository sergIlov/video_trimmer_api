json.id task.id.to_s
json.created_at task.created_at
json.url task.url
json.duration format_duration(task.duration)
json.state task.state