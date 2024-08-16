# frozen_string_literal: true

module Notifications
  class MessageParams
    def self.build_topic_message(topic, data)
      {
        topic:,
        data: build_payload(data),
        notification: build_notification(data),
        android: build_android_notification(data),
        apns: build_apns_payload,
        fcm_options: analytics_label
      }
    end

    def self.build_device_group_message(token, data)
      {
        token:,
        data: build_payload(data),
        notification: build_notification(data),
        android: build_android_notification(data),
        apns: build_apns_payload,
        fcm_options: analytics_label
      }
    end

    private_class_method def self.build_payload(data)
      { payload: { data: }.to_json }
    end

    private_class_method def self.build_android_notification(data)
      { notification: build_notification(data), direct_boot_ok: true }
    end

    private_class_method def self.build_notification(data)
      { title: data['title'], body: data['body'] }
    end

    private_class_method def self.build_apns_payload
      { payload: { aps: { sound: 'default' } } }
    end

    private_class_method def self.analytics_label
      { analytics_label: 'Notifications' }
    end
  end
end
