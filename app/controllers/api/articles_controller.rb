class Api::ArticlesController < ApplicationController
  def index
    @articles = Article.published.last(50)
  end
end
