Rails.application.routes.draw do
  resources :posts
  get '/current_user', to: 'current_user#index'
  get '/stocks', to: 'stocks#stock_list'
  get '/pending', to: 'current_user#pending'
  get '/traders', to: 'current_user#traders'
  get '/trader', to: 'current_user#trader'
  post '/create', to: 'current_user#create'
  post '/edit', to: 'current_user#edit_details'
  post '/approve', to: 'current_user#approve_user'

  post '/buy', to: 'transactions#buy'
  post '/sell', to: 'transactions#sell'
  post '/transaction', to: 'transactions#create_transaction'
  
  get '/transactions', to: 'transactions#index'
  get '/portfolio', to: 'stocks#current_stocks'
  get '/quote', to: 'stocks#get_quote'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end


