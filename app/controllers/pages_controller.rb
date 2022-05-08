# frozen_string_literal: true

class PagesController < HtmlController
  before_action :fetch_user, only: %I[destroy]

  def main
    #   file_path = "#{Rails.root}/public/files/app-ads.txt"

    #   send_data file_path, layout: false, type: 'plain/text'
  end
end
