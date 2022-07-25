json.comments @comments do |comment|
  json.id comment.id
  json.body comment.body
  json.post_id comment.post_id
  json.user_id comment.user_id
  json.created_at comment.created_at
  json.user comment.user
end
json.current_user_id @user.id if @user.present?
