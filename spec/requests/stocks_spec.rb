require 'rails_helper'

RSpec.describe "StocksController", type: :request do
  describe "Get Stock List" do
    it "returns a list of available stocks" do
      Stock.create!([{
        symbol: "AMD",
        company_name: "Advanced Micro Devices Inc.",
        price: 98.705
      },
      {
        symbol: "NVDA",
        company_name: "NVIDIA Corp",
        price: 175.605,
      }])

      trader = User.create(email: "trader@trader.com", password: "password", approved: true)
      trader.confirm
      sign_in trader

      get "/stocks"

      json = JSON.parse(response.body)
      expect(json.count).to eq(2)
      expect(json[0]["symbol"]).to eq('AMD')
      expect(json[1]["symbol"]).to eq('NVDA')
    end
  end

  describe "Get portfolio" do
    it "should return trader-owned stocks" do
      trader = User.create(email: "trader@trader.com", password: "password", approved: true)
      trader.confirm
      sign_in trader

      Stock.create!([{
        symbol: "AMD",
        company_name: "Advanced Micro Devices Inc.",
        price: 98.705
      },
      {
        symbol: "NVDA",
        company_name: "NVIDIA Corp",
        price: 175.605,
      }])

      Transaction.create!([{
        user_id: trader.id,
        stock_symbol: "AMD",
        stock_price: 98.705,
        stock_quantity: 1,
        transaction_type: 'buy'
      },
      {
        user_id: trader.id,
        stock_symbol: "NVDA",
        stock_price: 175.605,
        stock_quantity: 1,
        transaction_type: 'buy'
      }])

      get "/portfolio"

      json = JSON.parse(response.body)
      expect(json.count).to eq(3)
      expect(json["portfolio"][0]["symbol"]).to eq('AMD')
      expect(json["portfolio"][1]["symbol"]).to eq('NVDA')
    end
  end
end