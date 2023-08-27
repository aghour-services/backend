module Api
  class RatingsController < ApiController
    before_action :authenticate_user!, except: %i[index]
    before_action :find_firm, only: %i[index create]
    before_action :find_rating, only: %i[update destroy]

    def index
      @ratings = @firm.ratings.order(id: :desc)
    end

    def create
      @rating = @firm.ratings.create(rating_params.merge(user: current_user))

      if @rating.save
        render :create, status: :created
      else
        render json: @rating.errors, status: :unprocessable_entity
      end
    end

    def update
      return unless @rating.user == current_user

      if @rating.update(rating_params)
        render :update, status: :ok
      else
        render json: @rating.errors, status: :unprocessable_entity
      end
    end

    def destroy
      return unless @rating.user == current_user

      if @rating.destroy
        head :no_content
      end
    end

    private

    def find_firm
      @firm = Firm.find(params[:firm_id])
    end

    def find_rating
      @rating = Rating.find(params[:id])
    end

    def rating_params
      params.require(:rating).permit(:value, :comment)
    end
  end
end
