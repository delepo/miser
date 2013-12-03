class AddDateToOperations < ActiveRecord::Migration
  def change
    add_column :operations, :date, :date
  end
end
