# json.extract! @user, :id, :name, :self_introduction, :status, :prefecture

json.id @user.id
json.name @user.name
json.self_introduction @user.self_introduction
json.status @user.status
json.status_ja @user.status_i18n
json.prefecture @user.prefecture
