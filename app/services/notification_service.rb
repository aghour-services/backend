# frozen_string_literal: true

class NotificationService
  def initialize(article)
    @article = article

    @topic = "News-v2-#{Rails.env}"
    @topic = 'News-v2' if Rails.env == 'production'
  end

  def send
    fcm = FCM.new(
      'AIzaSyDuqo8CAeue4IVAdhGwJtdofArV_mzxdV4',
      'aghour-app-firebase.json',
      'aghour-app'
    )

    fcm.send_v1(message)
  end

  private

  def message
    # we can replace topic by token 'token': ''
    message_title = 'أخبار أجهور الكبرى'
    {
      topic: @topic,
      data: { payload: { data: { id: @article.id } }.to_json },
      notification: { title: message_title,
                      body: @article.description.first(500) },
      android: {},
      apns: { payload: { aps: { sound: 'default', category: Time.zone.now.to_i.to_s } } },
      fcm_options: { analytics_label: 'notification_from_backend' }
    }
  end
end
