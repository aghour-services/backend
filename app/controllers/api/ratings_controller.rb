module Api

    class RatingsController < ApiController
        before_action :authenticate_user!
        before_action :find_firm

        def create
            @rating = @firm.ratings.create(rating_params.merge(user: current_user))
            
            if @rating.save
                render :create, status: :created
            else
                render json: @rating.errors, status: :unprocessable_entity
            end
        end

        private

        def find_firm
            @firm = Firm.find(params[:firm_id])
        end
        
        def rating_params
            params.require(:rating).permit(:value, :comment, :firm_id)
        end
    end
end