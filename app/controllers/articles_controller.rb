# frozen_string_literal: true

class ArticlesController < HtmlController
  before_action :fetch_article, only: %I[show update edit destroy]

  def index
    @articles = Article.order(id: :desc).includes(:attachments).first(200)
  end

  def edit; end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def update
    @article.update(article_params)
    redirect_to edit_article_path(@article)
  end

  private

  def article_params
    params.require(:article).permit(:description, :status, :image_url)
  end

  def fetch_article
    @article = Article.find(params[:id])
  end
end
