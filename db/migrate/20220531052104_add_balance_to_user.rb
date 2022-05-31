class AddBalanceToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :balance, :bigint, :default => 1000
  end
end
