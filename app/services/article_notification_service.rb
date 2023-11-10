# frozen_string_literal: true

class ArticleNotificationService
  attr_reader :data

  def initialize(data)
    @data = data
  
    @topic = "News-v1" if Rails.env.development?
    @topic = "News-v2" if Rails.env.production?
  end

  def send
    fcm = FCM.new(Rails.application.credentials.fcm_server_key)
    options = construct_notification_from_params(data)
    
    fcm.send_to_topic(@topic, options)
  end

  private

  def construct_notification_from_params(data)
    new_data = data.merge!(create_data_object(data))
    new_data = new_data.merge(android_channel_id: data[:android_channel_id]) if data[:android_channel_id].present?
    {
      'notification' => new_data,
      'data' => new_data,
      'priority' => 'high',
      'contentAvailable' => true
    }
  end

  def create_data_object(_data)
    {
      'time' => Time.now.to_i,
      'sound' => 'default',
    }
  end
end
