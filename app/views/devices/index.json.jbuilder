json.array!(@devices) do |device|
  json.extract! device, :id, :name, :device_type, :location, :public_ip, :private_ip, :device_note, :addons, :general_status, :general_reloaded, :osname, :osram, :osprocessor
  json.url device_url(device, format: :json)
end
