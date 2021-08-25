class CategoriesController < ActionController::Base
  def index
  end

  def new
    @category = Category.new
  end

  def create
    # render json: {data: params}
    category = Category.create(category_params)
    render json: { data: category }
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :icon)
  end
end
