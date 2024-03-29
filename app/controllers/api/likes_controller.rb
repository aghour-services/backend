module Api
  class LikesController < ApiController
    before_action :authenticate_user!, only: %i[create unlike]
    before_action :user_ability, only: %i[create unlike]
    before_action :set_article, only: %i[index create unlike]

    def index
      @likes = @article.likes.includes(:user)
    end

    def create
      current_user.likes.create(article: @article)
      render json: @article.likes.count, status: :ok
    end

    def unlike
      current_user.likes.find_by(article: @article)&.destroy
      head :no_content
    end

    private

    def set_article
      @article = Article.find(params[:article_id])
    end
  end
end
