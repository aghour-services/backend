# frozen_string_literal: true

module Api
  class FirmsController < ApiController
    before_action :fetch_category, only: [:index]
    before_action :authenticate_user!, only: [:create]

    def index
      @firms = @category.firms.published.includes(:category).order('RANDOM()')
    end

    def create
      @firm = Firm.new(firm_params.merge(user: current_user))
      if @firm.save
        render :create, status: :created
      else
        render :errors, status: :unprocessable_entity
      end
    end

    private

    def firm_params
      params.require(:firm).permit(:name, :category_id, :description, :address, :phone_number, :fb_page, :email)
    end

    def fetch_category
      @category = Category.find params[:category_id]
    end
  end
end
