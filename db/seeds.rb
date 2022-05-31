# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.create!([{
  email: "admin@admin.com",
  password: "password",
  role: "admin",
  approved: true
},
{
  email: "test1@test.com",
  password: "password",
  approved: true,
},
{
  email: "test2@test.com",
  password: "password",
  approved: true,
}])

users = User.all
users.each do |user|
  user.confirm
end

Stock.create!([{
  symbol: "AMD",
  company_name: "Advanced Micro Devices Inc.",
  price: 98.705
},
{
  symbol: "NVDA",
  company_name: "NVIDIA Corp",
  price: 175.605,
},
{
  symbol: "AMC",
  company_name: "AMC Entertainment Holdings Inc - Class A",
  price: 12.2,
},
{
  symbol: "AAPL",
  company_name: "Apple Inc",
  price: 142.54,
},
{
  symbol: "BKSY",
  company_name: "BlackSky Technology Inc - Class A",
  price: 2.38,
},
{
  symbol: "SNAP",
  company_name: "Snap Inc - Class A",
  price: 14.33,
},
{
  symbol: "M",
  company_name: "Macy`s Inc",
  price: 22.36,
},
{
  symbol: "NU",
  company_name: "Nu Holdings Ltd Class A",
  price: 3.645,
},
{
  symbol: "BAC",
  company_name: "Bank Of America Corp.",
  price: 36.635,
},
{
  symbol: "SWN",
  company_name: "Southwestern Energy Company",
  price: 8.94,
}])

Transaction.create!([{
  user_id: User.second.id,
  stock_symbol: "NVDA",
  stock_price: 175.605,
  stock_quantity: 1,
  transaction_type: "buy",
  total: 175.605
},
{
  user_id: User.second.id,
  stock_symbol: "BAC",
  stock_price: 36.635,
  stock_quantity: 1,
  transaction_type: "buy",
  total: 36.635
},
{
  user_id: User.second.id,
  stock_symbol: "SWN",
  stock_price: 8.94,
  stock_quantity: 2,
  transaction_type: "buy",
  total: 17.88
},{
  user_id: User.third.id,
  stock_symbol: "NVDA",
  stock_price: 175.605,
  stock_quantity: 1,
  transaction_type: "buy",
  total: 175.605
},
{
  user_id: User.third.id,
  stock_symbol: "NU",
  stock_price: 3.645,
  stock_quantity: 1,
  transaction_type: "buy",
  total: 3.645
},
{
  user_id: User.third.id,
  stock_symbol: "SWN",
  stock_price: 8.94,
  stock_quantity: 2,
  transaction_type: "buy",
  total: 17.88
}])
