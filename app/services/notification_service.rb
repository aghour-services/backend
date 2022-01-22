class NotificationService
  def self.send
    fcm = FCM.new(
      "AIzaSyDuqo8CAeue4IVAdhGwJtdofArV_mzxdV4",
      "aghour-app-firebase.json",
      "aghour-app"
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
        title: "Test",
        body: "Test",
      },
      'android': {},
      'apns': {
        payload: {
          aps: {
            sound: "default",
            category: "#{Time.zone.now.to_i}"
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
