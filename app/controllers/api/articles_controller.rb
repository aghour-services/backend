class Api::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :user_ability, only: [:create]

  def index
    @articles = Article.published.order(id: :desc).first(50)
  end

  def create
    @article = Article.new(article_params.merge(user: current_user))
    @article.status = :draft if user_ability.can_publish?
    if @article.save
      redirect_to edit_article_path(@article)
    end
  end

  private

  def user_ability
    @user_ability = UserAbility.new(current_user)
  end
  
  def article_params
    params.require(:article).permit(:description, :status)
  end

end
