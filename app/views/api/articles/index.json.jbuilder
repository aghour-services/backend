# frozen_string_literal: true

json.array! @articles do |article|
  json.partial! partial: '/api/articles/article', article:
end
