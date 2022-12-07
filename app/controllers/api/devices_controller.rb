module Api
  class DevicesController < ApiController
    def create
      @device = Device.find_or_create_by(:device_id => params[:device_id])
      @device.token = params[:token]
      if @device.save
        render json: @device, status: :created
      end
    end
  end
end
