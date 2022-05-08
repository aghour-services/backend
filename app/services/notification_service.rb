# frozen_string_literal: true

class NotificationService
  def self.send(_article_id)
    return unless Rails.env == 'production'

    article = Article.find article_id
    fcm = FCM.new(
      'AIzaSyDuqo8CAeue4IVAdhGwJtdofArV_mzxdV4',
      'aghour-app-firebase.json',
      'aghour-app'
    )

    message = {
      'topic': 'News', # OR token if you want to send to a specific device
      # 'token': "000iddqd",
      'data': {
        payload: {
          data: {
            id: 1
          }
        }.to_json
      },
      'notification': {
        title: 'أخبار أجهور الكبرى',
        body: article.description.first(1000)
      },
      'android': {},
      'apns': {
        payload: {
          aps: {
            sound: 'default',
            category: Time.zone.now.to_i.to_s
          }
        }
      },
      'fcm_options': {
        analytics_label: 'Label'
      }
    }

    fcm.send_v1(message)
  end
end
