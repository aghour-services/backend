json.id @article.id
json.description @article.description
json.status @article.status
json.created_at @article.time_ago
json.likes_count @article.likes.count
json.user do
  json.partial! partial: "/api/users/user", user: @article.user
end