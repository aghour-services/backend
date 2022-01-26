class PagesController < HtmlController
  before_action :fetch_user, only: %I[destroy]

  def main
    file_path = "#{Rails.root}/public/files/app-ads.txt"

    send_file file_path
  end
end
