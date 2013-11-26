json.array!(@accounts) do |account|
  json.extract! account, :bank_id
  json.url account_url(account, format: :json)
end
