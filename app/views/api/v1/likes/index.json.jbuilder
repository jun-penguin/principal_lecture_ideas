json.likes @likes do |like|
  json.id like.id
  json.user_id like.user_id
  json.post_id like.post_id
end
json.current_user_id @user.id if @user.present?
