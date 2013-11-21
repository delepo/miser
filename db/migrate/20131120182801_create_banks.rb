class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.string :address
      t.string :bank_code
      t.string :branch_code

      t.timestamps
    end
  end
end
