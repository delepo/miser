json.array!(@banks) do |bank|
  json.extract! bank, :name, :address, :bank_code, :branch_code
  json.url bank_url(bank, format: :json)
end
