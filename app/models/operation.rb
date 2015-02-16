class Operation < ActiveRecord::Base
  belongs_to :account
  belongs_to :transfer_operation, class_name: "Operation"

  validates :amount, presence: true
  validates :amount, numericality:{greater_than_or_equal_to:0.01}
  validates :date, presence: true
end
