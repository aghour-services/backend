# frozen_string_literal: true

json.id rating.id
json.value rating.value
json.comment rating.comment
json.user do
  json.partial! partial: '/api/users/user', user: rating.user
end
json.firm do
  json.partial! partial: '/api/firms/firm', firm: rating.firm
end