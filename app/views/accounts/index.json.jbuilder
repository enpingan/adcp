json.array!(@accounts) do |account|
  json.extract! account, :id, :email_addr, :ssl_name, :hs_pwd, :is_ticket, :is_device
  json.url account_url(account, format: :json)
end
