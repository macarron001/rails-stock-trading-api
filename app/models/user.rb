class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :transactions
  has_many :stocks

  validates :email, presence: true
  validates :role, :inclusion => { :in => ['admin', 'trader']}
  validates :balance, numericality: {greater_than: 0}
  validates :approved, inclusion: { in: [ true, false ] }


  devise :database_authenticatable, :confirmable, :registerable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self


  def buy_stock(symbol, shares, user_id)
    transaction_params = {}
    transaction_params[:type] = 'buy'
    transaction_params[:symbol] = symbol
    transaction_params[:shares] = shares
    Transaction.create_transaction(transaction_params, user_id)
  end

  def sell_stock(symbol, shares, user_id)
    transaction_params = {}
    transaction_params[:type] = 'sell'
    transaction_params[:symbol] = symbol
    transaction_params[:shares] = shares
    Transaction.create_transaction(transaction_params, user_id)
  end

  def enough_balance?(total)
    return true if self.balance > total
  end

  def update_balance(total, type)
    if type == 'buy'
      new_balance = self.balance - total
    else
      new_balance = self.balance + total
    end
    self.update!(balance: new_balance)
  end 
end