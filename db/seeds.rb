require 'csv'

def import_articles
  data_entries = CSV.read('public/articles.csv', headers: true)
  data_entries.each do |entry|
    article = Article.new
    article.id = entry['id']
    article.description = entry['description']
    article.user_id = entry['user_id']
    article.created_at = entry['created_at']
    article.status = entry['status']
    article.save(validate: false)
  end
end

def import_categories
  data_entries = CSV.read('public/categories.csv', headers: true)
  data_entries.each do |entry|
    category = Category.new
    category.id = entry['id']
    category.name = entry['name']
    category.save(validate: false)
  end
end

def import_users
  data_entries = CSV.read('public/users.csv', headers: true)
  roles = { 0 => 'user', 1 => 'publisher', 2 => 'admin' }

  data_entries.each do |entry|
    user = User.new

    user.id = entry['id']
    user.name = entry['name']
    user.mobile = entry['mobile']
    user.email = entry['email']
    user.encrypted_password = entry['encrypted_password']
    user.token = entry['token']
    user.reset_password_token = entry['reset_password_token']
    user.reset_password_sent_at = entry['reset_password_sent_at']
    user.remember_created_at = entry['remember_created_at']
    user.created_at = entry['created_at']
    user.updated_at = entry['updated_at']
    user.role = roles[entry['role'].to_i]

    user.save(validate: false)
  end
end

def import_firms
  data_entries = CSV.read('public/firms.csv', headers: true)
  statuses = { 0 => 'draft', 1 => 'published' }
  data_entries.each do |entry|
    firm = Firm.new

    firm.id = entry['id']
    firm.name = entry['name']
    firm.description = entry['description']
    firm.address = entry['address']
    firm.phone_number = entry['phone_number']
    firm.email = entry['email']
    firm.fb_page = entry['fb_page']
    firm.category_id = entry['category_id']
    firm.created_at = entry['created_at']
    firm.updated_at = entry['updated_at']
    firm.status = statuses[entry['status'].to_i]
    firm.user_id = entry['user_id']
    firm.tags = entry['tags']

    firm.save(validate: false)
  end
end

# import_articles
# import_categories
# import_users
# import_firms
