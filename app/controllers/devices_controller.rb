class DevicesController < HtmlController

    def index
      @devices = Device.all
    end

end