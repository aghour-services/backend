class FirmsController < ActionController::Base
  before_action :fetch_category, except: %I[index]
  before_action :fetch_firm, only: %I[show update edit]

  def index
    @firms = Firm.all
    render json: { data: @firms }
  end

  def new
    @firm = Firm.new
  end

  def edit; end

  def update
    @firm.update(firm_params)
    redirect_to edit_category_firm_path(@category, @firm)
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
    @category = Category.find(params[:category_id])
  end

  def fetch_firm
    @firm = @category.firms.find_by!(id: params[:id])
  end
end
