json.array!(@accounts) do |account|
  json.extract! account, :name, :code, :balance, :bank_id
  json.url account_url(account, format: :json)
end
