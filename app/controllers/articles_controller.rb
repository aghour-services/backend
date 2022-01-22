class ArticlesController < HtmlController
  before_action :fetch_article, only: %I[show update edit destroy]

  def index
    @articles = Article.last(300)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def update
    @article.update(article_params)
    redirect_to edit_category_article_path(@article.category, @article)
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to edit_article_path(@article)
    else
      render 'new'
    end
  end

  private

  def article_params
    params.require(:article).permit(:description)
  end

  def fetch_article
    @article = Article.find(params[:id])
  end
end
