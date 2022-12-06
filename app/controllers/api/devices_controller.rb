module Api
  class DevicesController < ApiController
    def create
      @device = Device.find_or_create_by(device_params)
      if @device.save
        render json: @device, status: :created
      else
        render json: @device.errors , status: :unprocessable_entity
      end
    end

    def device_params
      params.require(:device).permit(:device_id, :token)
    end
  end
end
