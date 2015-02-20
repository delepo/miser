require 'test_helper'

class BankTest < ActiveSupport::TestCase
  fixtures :banks
  
  test "bank name must not be empty" do
    bank = Bank.new
    assert bank.invalid?
    assert bank.errors[:name].any?
  end
  
  test "bank name must be unique" do
    bank = Bank.new(name: banks(:laposte).name, address: "une adresse", bank_code: "2345", branch_code: "12345")
    assert bank.invalid?
    assert_equal [I18n.translate('activerecord.errors.messages.taken')], bank.errors[:name]
  end
end
