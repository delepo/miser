class Account < ActiveRecord::Base
  belongs_to :bank
  has_many :operations
  validates :name, presence: true, uniqueness: true
  validates :balance, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than_or_equal_to: 0 }

  def final_balance
    balance + operations.to_a.sum { |operation| operation.amount }
  end

  def balance_until_operation(operation)
    balance + operations.where('created_at <= ?', operation.created_at).to_a.sum { |operation| operation.amount }
  end

  def self.all_except(account)
    where.not(id: account)
  end
end
