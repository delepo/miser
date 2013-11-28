class AddFieldsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :name, :string
    add_column :accounts, :code, :string
    add_column :accounts, :balance, :decimal, default: 0
  end
end
