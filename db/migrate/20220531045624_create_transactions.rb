class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    drop_table :transactions

    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true

      t.string :stock_symbol
      t.decimal :stock_price
      t.integer :stock_quantity
      t.string :transaction_type
      t.decimal :total

      t.timestamps
    end
  end
end
