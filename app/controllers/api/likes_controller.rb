module Api
  class LikesController < ApiController
    before_action :authenticate_user!
    before_action :set_article

    def create
      @like = @article.likes.create(user: current_user)

      if @like.save
        render json: { message: "#{current_user.name} liked this article" }, status: :ok
      else
        render json: { error: "You must create an account" }, status: :unauthorized
      end
    end

    def destroy
      @like = @article.likes.find(params[:id])

      if @like.destroy
        render json: { message: "#{current_user.name} removed like" }, status: :ok
      else
        render json: { error: "You must create an account" }, status: :unauthorized
      end
    end

    private

    def set_article
      @article = Article.find(params[:article_id])
    end
  end
end
