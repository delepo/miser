class RenameTypeColumn < ActiveRecord::Migration
  def change
    rename_column :operations, :type, :transaction_type
  end
end
