module Api
    class NotificationsController < ApiController
        def index
            @notifications = Notification.order(created_at: :desc).limit(50)
        end
    end    
end