json.set! :posts do
  json.array! @posts do |post|
    json.extract! post, :id, :title, :description, :content, :status
  end
end

# json.array! @posts, :id, :title
