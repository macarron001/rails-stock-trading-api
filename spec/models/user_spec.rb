require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validating user creation' do
    it 'is not valid without email' do
      user = User.new
      user.email = nil

      expect(user).not_to be_valid
    end

    it 'is not valid without password' do
      user = User.new
      user.password = nil

      expect(user).not_to be_valid
    end
  end

  context 'validating user associations' do
    it "has many stocks" do
      should respond_to(:stocks)
    end

    it "has many transactions" do
      should respond_to(:transactions)
    end
  end

  context 'validate default attributes'
    it 'upon creation status must be unapproved' do 
      user = User.create!(email: "new@user.com", password: "password")

      expect(user.approved).to eq(false)
    end

    it 'upon creation role must be trader' do 
      user = User.create!(email: "new@user.com", password: "password")

      expect(user.role).to eq('trader')
    end

    it 'upon creation balance must be 100' do 
      user = User.create!(email: "new@user.com", password: "password")

      expect(user.balance).to eq(1000)
    end

  context 'Admin Capabilities' do 
    it 'can create a user' do 
      user = User.new(email: "new@user.com", password: "password")

      expect(user.valid?).to eq(true)
    end

    it 'can approve a pending user' do 
      user = User.create!(email: "new@user.com", password: "password")
      user.update!(approved: true)
      expect(user.approved).to eq(true) 
    end
  end

  context 'Buy / Sell' do 
    it 'can buy stocks' do 
      user = User.create!(email: "new@user.com", password: "password")
      Stock.create!(symbol: 'SOFI', company_name: 'SOFI', price: 2)

      stock = user.buy_stock('SOFI', 2, user.id)
      expect(user.transactions.count).to eq 1
      expect(user.transactions.first.transaction_type).to eq 'buy'
    end

    it 'can sell stocks' do 
      user = User.create!(email: "new@user.com", password: "password")
      Stock.create!(symbol: 'SOFI', company_name: 'SOFI', price: 2)

      stock = user.sell_stock('SOFI', 2, user.id)
      expect(user.transactions.count).to eq 1
      expect(user.transactions.first.transaction_type).to eq 'sell'
    end

    it 'cannot buy stocks if balance is not enough' do
      user = User.create!(email: "new@user.com", password: "password")
      Stock.create!(symbol: 'SOFI', company_name: 'SOFI', price: 2)
      stock = user.buy_stock('SOFI', 9999999, user.id)

      expect(user.transactions.count).to eq 0
    end
  end
end