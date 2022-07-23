json.comments @comments do |comment|
  json.id comment.id
  json.body comment.body
  json.post_id comment.post_id
  json.user_id comment.user_id
  json.user_id comment.updated_at
  json.user comment.user
end
