class NotificationRepo
    def initialize(notifiable, user, title, body, image_url)
        @notifiable = notifiable
        @user = user
        @title = title
        @body = body
        @image_url = image_url
    end

    def create
        Notification.create!(
            notifiable: @notifiable,
            user: @user,
            title: @title,
            body: @body,
            image_url: @image_url
        )
    end
end