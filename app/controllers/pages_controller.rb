class PagesController < HtmlController
  before_action :fetch_user, only: %I[destroy]

  def main
    
  end
end
