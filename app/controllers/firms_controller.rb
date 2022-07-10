# frozen_string_literal: true

class FirmsController < HtmlController
  before_action :fetch_category, except: %I[index]
  before_action :fetch_firm, only: %I[show update edit destroy]

  def index
    @firms = Firm.includes(:category, :user).order(id: :desc).limit(300)
    @firms = @firms.where(category_id: params[:category_id]) if params[:category_id]
  end

  def new
    @firm = Firm.new
  end

  def edit; end

  def destroy
    @firm.destroy
    redirect_to firms_path
  end

  def update
    @firm.update(firm_params)
    redirect_to edit_category_firm_path(@firm.category, @firm)
  end

  def create
    @firm = Firm.new(firm_params.merge(category_id: @category.id, status: :published))
    if @firm.save
      redirect_to edit_category_firm_path(@category, @firm)
    else
      render 'new'
    end
  end

  private

  def firm_params
    params.require(:firm).permit(:name, :description, :tags, :address, :phone_number,
                                 :fb_page, :email, :category_id, :status)
  end

  def fetch_category
    @category = Category.find(params[:category_id])
  end

  def fetch_firm
    @firm = Firm.find(params[:id])
  end
end
