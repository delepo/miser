class Operation < ActiveRecord::Base
  belongs_to :account
  belongs_to :transfer_operation, class_name: "Operation"

  validate :amount_cannot_be_zero
  validates :date, presence: true

  def amount_cannot_be_zero
    if !amount.present? || amount == 0
      errors.add(:amount, I18n.t('activerecord.errors.models.operation.attributes.amount.greater_than_or_equal_to'))
    end
  end
end
