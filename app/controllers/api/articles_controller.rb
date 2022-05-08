# frozen_string_literal: true

module Api
  class ArticlesController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    before_action :user_ability, only: [:create]

    def index
      @articles = Article.published.order(id: :desc).first(50)
    end

    def create
      @article = Article.new(article_params.merge(user: current_user))
      @article.status = :draft if user_ability.can_publish?
      redirect_to edit_article_path(@article) if @article.save
    end

    private

    def user_ability
      @user_ability = UserAbility.new(current_user)
    end

    def article_params
      params.require(:article).permit(:description, :status)
    end
  end
end
