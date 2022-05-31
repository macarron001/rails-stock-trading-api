require 'rails_helper'

RSpec.describe "TransactionsController", type: :request do
  describe "Get Transactions by Admin" do
    
    it "shows all existing transactions" do

      admin = create(:user)
      admin.confirm
      sign_in admin

      trader = User.create(email: "trader@trader.com", password: "password", approved: true)
      transaction = Transaction.create!(user_id: trader.id, stock_symbol: 'SOFI', stock_price: 1, stock_quantity: 1, transaction_type: 'buy')

      get "/transactions"
      json = JSON.parse(response.body)

      expect(json[0]["stock_symbol"]).to eq("SOFI")
      expect(json[0]["transaction_type"]).to eq("buy")
    end
  end

  describe "Get Transactions by Trader" do

    it "shows all trader-owned transactions" do
      trader = User.create!(email: "trader@trader.com", password: "password", approved: true)
      trader.confirm
      sign_in trader
      transaction = Transaction.create!(user_id: trader.id, stock_symbol: 'SOFI', stock_price: 1, stock_quantity: 1, transaction_type: 'buy')

      get "/transactions"
      json = JSON.parse(response.body)

      expect(json[0]["stock_symbol"]).to eq("SOFI")
      expect(json[0]["transaction_type"]).to eq("buy")
    end
  end
end