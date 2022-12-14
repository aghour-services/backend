class DevicesController < HtmlController
    def index
      @devices = Device.all.order(last_usage_time: :desc).limit(200)
    end
end
