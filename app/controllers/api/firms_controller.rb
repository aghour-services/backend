class Api::FirmsController < ApplicationController
  before_action :fetch_category

  def index
    @firms = @category.firms.order(:id)
  end

  private

  def fetch_category
    @category = Category.find params[:category_id]
  end
end
