# frozen_string_literal: true

json.array! @notifications do |notification|
  json.partial! partial: '/api/notifications/notification', notification:
end
