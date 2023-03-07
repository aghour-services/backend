json.array! @likes do |like|
  json.partial! partial: "/api/users/user", user: like.user
end
