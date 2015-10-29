json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :group, :subject, :owner, :last_replied, :device, :updated, :user_id, :is_read
  json.url ticket_url(ticket, format: :json)
end
