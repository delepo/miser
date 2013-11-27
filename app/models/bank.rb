class Bank < ActiveRecord::Base
  has_many :accounts
  before_destroy :ensure_not_referenced_by_any_account

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :bank_code, uniqueness: true

  private
  def ensure_not_referenced_by_any_account
    if accounts.empty?
    return true
    else
      errors.add(:base, 'Accounts present')
    return
    end
  end
end
