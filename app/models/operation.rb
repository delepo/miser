class Operation < ActiveRecord::Base
  belongs_to :account
  belongs_to :transfer_account

  validates :amount, presence: true
  validates :date, presence: true
  validates :transaction_type, presence: true

end
