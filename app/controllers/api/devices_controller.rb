module Api
  class DevicesController < ApiController
    before_action :authenticate_user, only: [:create]

    def create
      if current_user.present?
        @device = Device.find_or_create_by(token: device_params[:token])
        @device.token = device_params[:token]
        @device.user = current_user
        render json: @device, status: :created if @device.save
      else
        @device = Device.find_or_create_by(token: device_params[:token])
        @device.token = device_params[:token]
        render json: @device, status: :created if @device.save
      end
    end

    private

    def device_params
      params.permit(:token)
    end
  end
end
