# frozen_string_literal: true

module Notifications
  class Sender
    attr_reader :data

    def initialize(data = {})
      @data = data
    end

    def send_to_topic
      return unless Rails.env.production?

      fcm.send_v1(build_topic_message('News-v2'))
    end

    def send_to_specific_user(recipient_id)
      return unless Rails.env.production?
  
      tokens = registration_ids(recipient_id)
      return if tokens.blank?

      tokens.each do |token|
        fcm.send_v1(build_device_group_message(token))
      end
    end

    def send_to_specific_users(tokens)
      return unless Rails.env.production?
      return if tokens.blank?

      tokens.each do |token|
        fcm.send_v1(build_device_group_message(token))
      end
    end

    private

    def fcm
      FCM.new(nil, 'aghour-app-firebase.json','aghour-app')
    end

    def fcm_service
      Notifications::FcmService.new(client_id)
    end

    def build_topic_message(topic)
      Notifications::MessageParams.build_topic_message(topic, data)
    end

    def build_device_group_message(token)
      Notifications::MessageParams.build_device_group_message(token, data)
    end

    def registration_ids(recipient_id)
      Device.where(deviceable_id: recipient_id).pluck(:registration_id).compact.reject(&:empty?)
    end
  end
end
