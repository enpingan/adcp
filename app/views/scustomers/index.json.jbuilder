json.array!(@scustomers) do |scustomer|
  json.extract! scustomer, :id, :username
  json.url scustomer_url(scustomer, format: :json)
end
