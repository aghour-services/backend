json.array! @articles do |article|
  json.partial! partial: '/api/articles/article', article: article
end
