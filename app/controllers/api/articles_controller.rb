class Api::ArticlesController < ApplicationController
  def index
    @articles = Article.last(50)
  end
end
