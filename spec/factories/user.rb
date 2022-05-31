FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    role { 'admin' }
    approved { true }
  end
end