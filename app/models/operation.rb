class Operation < ActiveRecord::Base
  belongs_to :account
  belongs_to :transfer_account

  validates :amount, presence: true
  validates :date, presence: true
  validates :transaction_type, presence: true

  TRANSACTION_TYPES = {'EXPENDITURE' => 0, 'INCOME' => 1, 'TRANSFER' => 2}
end
