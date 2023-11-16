# frozen_string_literal: true

json.id notification.id
json.title notification.title
json.body notification.body
json.image_url notification.image_url
json.created_at notification.time_ago
json.user do
  json.partial! partial: '/api/users/user', user: notification.user
end
