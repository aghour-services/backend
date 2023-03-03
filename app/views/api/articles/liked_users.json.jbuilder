json.liking_users do
  json.array! @article.liking_users do |user|
    json.partial! partial: "/api/likes/like", user: user
  end
end
