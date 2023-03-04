# frozen_string_literal: true

module Api
  class ArticlesController < ApiController
    CACHE_KEY = "articles#index"

    before_action :authenticate_user!, only: %i[create update destroy like unlike]
    before_action :user_ability, only: %i[create update destroy like unlike]
    before_action :find_article, only: %i[show update destroy like unlike liked_users]

    # after_action :cache_response, only: [:index]
    # before_action :check_cached, only: [:index]

    def index
      # if @cached_response
      #   render json: @cached_response
      #   return
      # end
      @articles = Article.includes(:user, :comments).published.order(id: :desc).first(50)
    end

    def show; end

    def create
      @article = Article.new(article_params.merge(user: current_user))
      @article.status = :published if user_ability.can_publish?

      render :create, status: :created if @article.save
    end

    def update
      return not_the_article_owner unless @article.user == current_user

      if @article.update(article_params)
        render :update, status: :ok
      else
        render json: { error: @article.errors.messages }, status: :unprocessable_entity
      end
    end

    def not_the_article_owner
      render json: { error: "You can only edit your own articles" }, status: :unauthorized
    end

    def destroy
      if @article.user == current_user
        head :no_content if @article.destroy
      else
        render json: { error: "You can only delete your own articles" }, status: :unauthorized
      end
    end

    def like
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

    def liked_users
      @likes = @article.liking_users
    end

    private

    def find_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:description)
    end

    # def check_cached
    #   @cached_response = REDIS_CLIENT.get CACHE_KEY
    # rescue StandardError => e
    # end

    # def cache_response
    #   REDIS_CLIENT.setex CACHE_KEY, 3.hours, response.body
    # rescue StandardError => e
    # end
  end
end
