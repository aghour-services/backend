class DevicesController < HtmlController
    def index
      @devices = Device.order(last_usage_time: :desc)
    end
end