# frozen_string_literal: true

module Api
  class ArticlesController < ApiController
    CACHE_KEY = 'articles#index'

    before_action :authenticate_user!, only: [:create]
    before_action :user_ability, only: [:create]

    after_action :cache_response, only: [:index]
    before_action :check_cached, only: [:index]

    def index
      if @cached_response
        render json: @cached_response
        return
      end
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

    def check_cached
      @cached_response = REDIS_CLIENT.get CACHE_KEY
    rescue StandardError => e
    end

    def cache_response
      REDIS_CLIENT.setex CACHE_KEY, 3.hours, response.body
    rescue StandardError => e
    end
  end
end
