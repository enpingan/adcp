json.array!(@verifieds) do |verified|
  json.extract! verified, :id, :username, :password, :email
  json.url verified_url(verified, format: :json)
end
