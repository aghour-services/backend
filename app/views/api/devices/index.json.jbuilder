json.array! @devices do |device|
  json.partial! 'devices', device: device
end
