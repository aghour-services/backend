class Api::FirmsController < ApplicationController
  before_action :fetch_category

  def index
    @firms = @category.firms.includes(:category).order(:id)
  end

  private

  def fetch_category
    @category = Category.find params[:category_id]
  end
end
