class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client

  def stock_list
    list = Stock.all
    render json: list
  end

  def current_stocks
    transactions = Transaction.set_transactions(current_user.id)
    portfolio = Stock.set_portfolio(transactions[0], transactions[1])
    
    render json: json = {
      total_investment: portfolio[1].sum, 
      balance: current_user.balance,
      portfolio: portfolio[0]
    }
  end

  def get_quote
    quote = @client.quote(params[:symbol])
    render json: quote
  end

  private

  def set_client
    @client = IEX::Api::Client.new(
      publishable_token: ENV['PUBLISHABLE_TOKEN'],
      secret_token: ENV['SECRET_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end
end
