module Api
  class DevicesController < ApiController
    def index
      @devices = Device.all
    end

    def new
      @device = Device.new
    end

    def create
      @device = Device.find_or_create_by(device_params)
      if @device.save
        redirect_to root_path, notice: "Device was successfully created."
      else
        render json: @device.errors , status: :unprocessable_entity
      end
    end

    def device_params
      params.require(:device).permit(:device_id, :token)
    end
  end
end
