class Stock < ApplicationRecord
  has_many :users

  validates :symbol, presence: true
  validates :company_name, presence: true
  validates :price, numericality: {greater_than: 0}

  
  def self.get_client
    @client = IEX::Api::Client.new(
      publishable_token: ENV['PUBLISHABLE_TOKEN'],
      secret_token: ENV['SECRET_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end
  
  def self.stock_list
    stocks = get_client.stock_market_list(:mostactive)
    filtered = stocks.map{|h| {company_name: h['company_name'] ,sym: h['symbol'],price: h['latest_price'] }}
  end

  def self.get_quote(symbol)
    get_client
    stock = @client.quote(symbol)
  end

  def self.set_portfolio(current_stocks, quantity)
    shares = quantity
    stocks = current_stocks.uniq
    portfolio = []
    portfolio_total = []
    stocks.each_with_index do |s, i|
      quote = {}
      stock = Stock.find_by(symbol: s)
      price = stock.price
      quote[:company] = stock.company_name
      quote[:symbol] = stock.symbol
      quote[:price] = price
      quote[:shares] = shares[i]
      quote[:total] = price * shares[i]
      portfolio << quote
      portfolio_total << price * shares[i]
    end
    
    return portfolio, portfolio_total
  end
end
