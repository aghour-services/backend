# frozen_string_literal: true

json.array! @firms do |firm|
  json.partial! partial: '/api/firms/firm', firm: firm
end
