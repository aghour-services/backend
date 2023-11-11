# frozen_string_literal: true

class NotificationService
  attr_reader :data

  def initialize(data)
    @data = data
  
    @topic = "News-v1"
  end

  def send
    # return unless Rails.env.production?

    fcm = FCM.new(Rails.application.credentials.fcm_server_key)
    options = construct_notification_from_params(data)
    
    fcm.send_to_topic(@topic, options)
  end

  private

  def construct_notification_from_params(data)
    new_data = data.merge!(create_data_object(data))
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
