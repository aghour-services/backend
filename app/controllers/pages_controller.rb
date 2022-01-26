class PagesController < HtmlController
  before_action :fetch_user, only: %I[destroy]

  def main
    file_path = "#{Rails.root}/public/app-ads.txt"

    render file: file_path, layout: false, content_type: 'text/plain'
  end
end
