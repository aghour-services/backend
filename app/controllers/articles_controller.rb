# frozen_string_literal: true

class ArticlesController < HtmlController
  before_action :fetch_article, only: %I[show update edit destroy]

  def index
    @articles = Article.order(id: :desc).last(300)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if params[:article][:image_url].present?
      imgur_link = ImgurUploader.upload(params[:article][:image_url].tempfile.path)
      @article.image_url = imgur_link
    end

    if @article.save
      redirect_to articles_path
    else
      render :new
    end
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
