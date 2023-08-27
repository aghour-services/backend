# frozen_string_literal: true

json.array! @ratings do |rating|
  json.partial! partial: '/api/ratings/rating', rating:
end
