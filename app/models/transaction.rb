class Transaction < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :stock_symbol, presence: true
  validates :stock_price, presence: true
  validates :stock_quantity, presence: true
  validates :transaction_type, :inclusion => { :in => ['buy', 'sell']}

  def self.create_transaction(transaction_params, user_id)
    user = User.find(user_id)
    symbol = transaction_params[:symbol].to_s
    shares = transaction_params[:shares].to_i
    type = transaction_params[:type].to_s
    stock = Stock.find_by(symbol: symbol)
    price = stock.price
    symbol = stock.symbol
    total = price * shares

    if user.enough_balance?(total)
      @transaction = Transaction.create(
        :stock_symbol => symbol, 
        :user_id => user_id, 
        :stock_price => price,
        :stock_quantity => shares,  
        :transaction_type => type, 
        :total => total,
      )
      user.update_balance(total, type)
    end   
  end

  def self.set_transactions(user_id)
    #returns user-currently-owned stocks after going through transactions
    current_stocks = []
    shares = []

    transactions = Transaction.all.where(user_id: user_id)
    symbols = transactions.pluck(:stock_symbol)
    symbols.each do |symbol|
      filtered_transactions = Transaction.filter_transactions(transactions, symbol)
      buy_transactions = Transaction.get_buy_transactions(filtered_transactions)
      sell_transactions = Transaction.get_sell_transactions(filtered_transactions)
      buy_quantity = Transaction.get_quantity(buy_transactions)
      sell_quantity = Transaction.get_quantity(sell_transactions)

      remaining_transactions = buy_transactions.count - sell_transactions.count
      remaining_quantity = buy_quantity - sell_quantity

      if remaining_transactions > 0 && remaining_quantity > 0
        current_stocks.push(symbol)
        shares.push(remaining_quantity)
      end
    end

    return current_stocks, shares
  end

  def self.filter_transactions(transactions, symbol)
    transactions.all.where(stock_symbol: symbol)
  end

  def self.get_buy_transactions(filtered_transactions)
      filtered_transactions.all.where(transaction_type: 'buy')
  end

  def self.get_sell_transactions(filtered_transactions)
      filtered_transactions.all.where(transaction_type: 'sell')
  end

  def self.get_quantity(transactions)
    quantity = transactions.pluck(:stock_quantity).sum
  end
end
