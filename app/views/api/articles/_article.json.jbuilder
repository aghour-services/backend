# frozen_string_literal: true

json.id article.id
json.description article.description
json.status article.status
json.created_at article.time_ago
json.partial! partial: '/api/users/user', user: article.user
json.latest_comment do
  json.partial! partial: '/api/comments/comment', comment: article.comments.last if article.comments.last
end
