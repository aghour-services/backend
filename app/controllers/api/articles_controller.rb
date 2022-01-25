class Api::ArticlesController < ApplicationController
  def index
    @articles = Article.published.order(id: :desc).last(50)
  end
end
