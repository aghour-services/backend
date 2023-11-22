# frozen_string_literal: true

json.id notification.id
json.title notification.title
json.body notification.body
json.notifiable_id notification.notifiable_id
json.notifiable_type notification.notifiable_type
json.article_id notification.article_id
json.image_url notification.image_url
json.created_at notification.time_ago
json.user do
  json.partial! partial: '/api/users/user', user: notification.user
end
