class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.integer :balance
      t.integer :user_id

      t.timestamps
    end
    add_index :balances, [:user_id]
  end
end
