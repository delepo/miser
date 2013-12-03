json.array!(@operations) do |operation|
  json.extract! operation, :account_id, :date, :transfer_account_id, :amount, :transaction_type
  json.url operation_url(operation, format: :json)
end
