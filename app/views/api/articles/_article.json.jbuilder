# frozen_string_literal: true

json.id article.id
json.description article.description
json.status article.status
json.image article.image_url
json.likes_count article.likes.count
json.comments_count article.comments.count
json.liked article.liked?(@current_user)
json.created_at article.time_ago
json.user do
  json.partial! partial: '/api/users/user', user: article.user
end
json.latest_comment do
  json.partial! partial: '/api/comments/comment', comment: article.comments.last if article.comments.last
end
