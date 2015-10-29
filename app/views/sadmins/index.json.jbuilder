json.array!(@sadmins) do |sadmin|
  json.extract! sadmin, :id, :username
  json.url sadmin_url(sadmin, format: :json)
end
