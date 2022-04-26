json.set! :posts do
  json.array! @posts do |post|
    json.extract! post, :id, :title, :description, :content
  end
end