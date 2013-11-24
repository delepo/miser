require 'test_helper'

class BankTest < ActiveSupport::TestCase
  test "bank name must not be empty" do
    bank = Bank.new
    assert bank.invalid?
    assert bank.errors[:name].any?
  end
end
