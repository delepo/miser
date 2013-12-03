class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.belongs_to :account, index: true
      t.references :transfer_account, index: true
      t.decimal :amount
      t.integer :type

      t.timestamps
    end
  end
end
