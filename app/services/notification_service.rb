# frozen_string_literal: true

class NotificationService
  def self.send(article_id)
    topic = 'News'
    topic = 'News-Staging' unless Rails.env == 'production'

    article = Article.find article_id
    fcm = FCM.new(
      'AIzaSyDuqo8CAeue4IVAdhGwJtdofArV_mzxdV4',
      'aghour-app-firebase.json',
      'aghour-app'
    )

    message = {
      'topic': topic, # OR token if you want to send to a specific device
      # 'token': 'e-qOe8viR3eomoItWV5X-0:APA91bGnxT6GGOlDBpveMk81oimqruSeZj7g3O39RCDTQWxoUP1BecrLtw37cA-i0TsYxsQJRXU3K6nTzugPNcqsuylD6bFo9Z3Kt1ChkKUbQ4Bb3_eCPJYe7E72yXEI4F18hnaOvBMO',
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
