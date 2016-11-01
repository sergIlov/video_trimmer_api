json.id task.id.to_s
json.created_at task.created_at
json.original_video_id task.video.id.to_s
json.duration format_duration(task.duration)
json.state task.state