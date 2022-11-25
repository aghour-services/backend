# frozen_string_literal: true

json.id comment.id
json.body comment.body
json.partial! partial: '/api/users/user', user: comment.user
