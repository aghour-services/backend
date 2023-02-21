class DevicesRepo
  def update_usage_time(fcm_token)
    Device.where(token: fcm_token).update(last_usage_time: Time.now)
  end
end
