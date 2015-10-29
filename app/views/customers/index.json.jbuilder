json.array!(@customers) do |customer|
  json.extract! customer, :id, :username, :password
  json.url customer_url(customer, format: :json)
end
