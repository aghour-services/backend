module Api
  class DevicesController < ApiController
    def create
      @device = Device.find_or_create_by(:token => params[:token], user: current_user)
      @device.token = params[:token]
      if @device.save
        render json: @device, status: :created
      end
    end
  end
end
