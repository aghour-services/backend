# frozen_string_literal: true

json.array! @tags do |tag|
  json.partial! partial: '/api/categories/tag', tag: tag
end
