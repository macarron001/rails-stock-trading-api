require 'rails_helper'

RSpec.describe Stock, type: :model do

  context 'validating stock associations' do
    it "has many users" do
      should respond_to(:users)
    end
  end

  context 'validating client' do
    it "get client through iex:api" do
      client = Stock.get_client

      expect(client.publishable_token).to eq(ENV['PUBLISHABLE_TOKEN'])
      expect(client.secret_token).to eq(ENV['SECRET_TOKEN'])
    end
  end
end