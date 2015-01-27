class Account < ActiveRecord::Base
  belongs_to :bank
  validates :name, presence: true, uniqueness: true
  validates :balance, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than_or_equal_to: 0 }

  def final_balance
    balance
  end
end
