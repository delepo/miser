class RefactorOperationTable < ActiveRecord::Migration
  def change
    remove_index :operations, column: :transfer_account_id
    rename_column :operations, :transfer_account_id, :transfer_operation_id
    remove_column :operations, :transaction_type
  end
end
