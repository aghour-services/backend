class Api::ArticlesController < ApplicationController
  def index
    @articles = Article.published.order(id: :desc).first(50)
  end
end
