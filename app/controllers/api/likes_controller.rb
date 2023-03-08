module Api
  class LikesController < ApiController
    before_action :authenticate_user!, only: %i[create unlike]
    before_action :user_ability, only: %i[create unlike]
    before_action :set_article, only: %i[index create unlike]

    def index
      @likes = @article.likes.includes(:user)
    end

    def create
      if @article
        current_user.likes.create(article: @article)
        render json: @article.likes.count, status: :ok
      else
        render json: { error: "Article not found" }, status: :not_found
      end
    end

    def unlike
      if @article && current_user.likes.find_by(article: @article)&.destroy
        render json: @article.likes.count, status: :ok
      else
        render json: { error: "Article not found or not liked by user" }, status: :not_found
      end
    end

    private

    def set_article
      @article = Article.find_by(id: params[:article_id])
    end
  end
end
