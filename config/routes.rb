Rails.application.routes.draw do
  root to: "users#index"

  namespace 'api' do
    resources :users
    get '/userslength', to: 'users#users_length'
  end
end
