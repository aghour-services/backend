# frozen_string_literal: true

json.array! @comments do |comment|
  json.partial! partial: '/api/comments/comment', comment:
end
