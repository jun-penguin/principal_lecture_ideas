# json.set! :posts do
#   json.array! @posts do |post|
#     json.extract! post, :id, :title, :description, :content, :grade_range, :user
#   end
# end

json.posts @posts do |post|
  json.id post.hashid
  json.title post.title
  json.description post.description
  json.content post.content
  json.grade_range_ja post.grade_range_i18n
  json.scene_type_ja post.scene_type_i18n
  json.updated_at post.updated_at
  json.user_name post.user.name
  json.likes_count post.likes.length
  json.comments_count post.comments.length
end
