require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'validate transaction relationship to user' do
    it "belongs to a user" do
      transaction = Transaction.new
      user = User.new
      user.transactions << transaction
      expect(transaction.user).to be user
    end
  end

  context 'validate creation of "buy" transaction record' do
    it "should create a 'buy' transaction record" do
      Stock.create!(symbol: 'SOFI', company_name: 'SOFI', price: 2)
      user = User.create!(email: "hello@test.com", password: "password", id: 15)
      user.buy_stock('SOFI', 1, user.id)

      trader = User.find(15)
      expect(trader.transactions.count).to eq 1
    end
  end

  context 'validate creation of "sell" transaction record' do
    it "should create a 'sell' transaction record" do
      Stock.create!(symbol: 'SOFI', company_name: 'SOFI', price: 2)
      user = User.create!(email: "hello@test.com", password: "password", id: 15)
      user.sell_stock('SOFI', 1, user.id)

      trader = User.find(15)
      expect(trader.transactions.count).to eq 1
    end
  end

  context 'validate update of user balance' do
    it "should subtract total from the balance" do
      Stock.create!(symbol: 'SOFI', company_name: 'SOFI', price: 2)
      user = User.create!(email: "hello@test.com", password: "password", id: 15)
      user.buy_stock('SOFI', 1, user.id)

      trader = User.find(15)
      expect(trader.balance).to be < 10000
    end

    it "should add total to the balance" do
      Stock.create!(symbol: 'SOFI', company_name: 'SOFI', price: 2)
      user = User.create!(email: "hello@test.com", password: "password", id: 15)
      user.sell_stock('SOFI', 1, user.id)

      trader = User.find(15)
      expect(trader.balance).to be > 100
    end
  end

end