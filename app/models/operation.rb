class Operation < ActiveRecord::Base
  belongs_to :account
  belongs_to :transfer_operation, class_name: "Operation"

  validates :amount, presence: true
  validates :date, presence: true
end
