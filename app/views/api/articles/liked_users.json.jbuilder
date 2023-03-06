json.liking_users do
  json.array! @article.liking_users do |user|
    json.partial! partial: "/api/users/user", user: user
  end
end
