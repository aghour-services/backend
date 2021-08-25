class FirmsController < ActionController::Base
  before_action :fetch_category
  def index; end

  def new
    @firm = Firm.new
  end

  def create
    firm = Firm.create(firm_params.merge(category_id: @category.id))
    render json: { data: firm }
  end

  private

  def firm_params
    params.require(:firm).permit(:name, :description, :address, :phone_number)
  end

  def fetch_category
    @category = Category.find(params[:id])
  end
end
