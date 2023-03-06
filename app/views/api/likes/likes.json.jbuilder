# app/views/articles/likes.json.jbuilder
json.array! @likes do |like|
  json.users do |user|
    json.partial! partial: '/api/users/user', user: like.user
  end
end