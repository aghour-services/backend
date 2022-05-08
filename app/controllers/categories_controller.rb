# frozen_string_literal: true

class CategoriesController < HtmlController
  before_action :fetch_category, only: %I[show edit update]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.create(category_params)
    redirect_to edit_category_path(@category)
  end

  def update
    @category.update(category_params)
    redirect_to edit_category_path(@category)
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def fetch_category
    @category = Category.find params[:id]
  end
end
