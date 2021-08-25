json.array! @categories do |category|
  json.id category.id
  json.name category.name
  json.description category.description
  json.icon cloudinary_url(category.icon_path)
end
