# frozen_string_literal: true

module Api
  class ArticlesController < ApiController
    before_action :authenticate_user!, only: [:create]
    before_action :user_ability, only: [:create]

    def index
      @articles = Article.published.order(id: :desc).first(50)
    end

    def create
      @article = Article.new(article_params.merge(user: current_user))
      @article.status = :published if user_ability.can_publish?

      render :create, status: :created if @article.save
    end

    private

    def article_params
      params.require(:article).permit(:description)
    end
  end
end
