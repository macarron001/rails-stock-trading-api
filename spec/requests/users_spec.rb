require 'rails_helper'

RSpec.describe "CurrentUsersController", type: :request do
  describe "Get traders as admin" do

    it "returns all approved traders" do
      admin = create(:user)
      admin.confirm
      sign_in admin

      trader1 = User.create(email: "trader1@trader.com", password: "password", approved: true)
      trader2 = User.create(email: "trader2@trader.com", password: "password", approved: true)

      get "/traders"
      json = JSON.parse(response.body)
      expect(json.count).to eq(2)
      expect(json[0]["email"]).to eq("trader1@trader.com")
      expect(json[1]["email"]).to eq("trader2@trader.com")
    end
  end

  describe "Get pending users as admin" do

    it "returns all pending users" do
      admin = create(:user)
      admin.confirm
      sign_in admin

      trader1 = User.create(email: "trader1@trader.com", password: "password", approved: false)
      trader2 = User.create(email: "trader2@trader.com", password: "password", approved: false)

      get "/pending"
      json = JSON.parse(response.body)
      expect(json.count).to eq(2)
      expect(json[0]["email"]).to eq("trader1@trader.com")
      expect(json[1]["email"]).to eq("trader2@trader.com")
    end
  end

  describe "Create a trader as admin" do

    it "should create a trader" do
      admin = create(:user)
      admin.confirm
      sign_in admin

      post '/create', params: {user: {email: "hehe@hehe.com", password: "password"}}

      json = JSON.parse(response.body)

      expect(json["status"]).to eq(201)
      expect(json["message"]).to eq('User registered!')
    end
  end

  describe "Approve a trader as admin" do

    it "should approve a trader" do
      admin = create(:user)
      admin.confirm
      sign_in admin

      trader = User.create(email: "trader@trader.com", password: "password", approved: false)
      post '/approve', params: {id: trader.id }
     
      json = JSON.parse(response.body)

      expect(json["status"]).to eq(201)
      expect(json["message"]).to eq('User approved!')
    end
  end

  describe "Show specific trader as admin" do

    it "should return trader details" do
      admin = create(:user)
      admin.confirm
      sign_in admin

      trader = User.create(email: "trader@trader.com", password: "password", approved: false)
      get '/trader', params: {id: trader.id }
     
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(trader.id)
      expect(json["email"]).to eq(trader.email)
    end
  end
end