# frozen_string_literal: true

json.array! @results do |firm|
  json.partial! partial: '/api/firms/firm', firm: firm
end
