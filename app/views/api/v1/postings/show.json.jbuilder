# json.extract! @post, :id, :title, :description, :content, :status, :grade_range, :scene_type, :user_id

json.id @post.id
json.title @post.title
json.description @post.description
json.content @post.content
json.status @post.status
json.grade_range @post.grade_range
json.scene_type @post.scene_type
json.grade_range_ja @post.grade_range_i18n
json.scene_type_ja @post.scene_type_i18n