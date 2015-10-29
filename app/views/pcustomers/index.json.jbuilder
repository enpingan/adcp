json.array!(@pcustomers) do |pcustomer|
  json.extract! pcustomer, :id, :username
  json.url pcustomer_url(pcustomer, format: :json)
end
