# frozen_string_literal: true

json.id comment.id
json.body comment.body
json.created_at comment.time_ago

json.user do
  json.partial! partial: '/api/users/user', user: comment.user
end
