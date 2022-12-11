class DevicesRepo
  def update_usage_time(device_id)
    Device.where(device_id:).update(last_usage_time: Time.now)
  end
end
