json.array! @categories do |category|
  json.name category.name
  json.description category.description
  json.icon cloudinary_url(category.icon_path)
  # json.icon category.icon.attachment.try(:path)
end
