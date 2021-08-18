json.array! @categories do |category|
  json.name category.name
  json.description "category.description"
  json.icon_path "/icons/#{category.icon_name}"
end
