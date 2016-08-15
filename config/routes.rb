Rails.application.routes.draw do
  resources :divisions do
    resources :teams
    resources :games
  end
  resources :teams do
    resources :games
    resources :players
  end
  resources :games
  resources :players
  resources :users
  root to: 'visitors#index'
  get '/registration' => 'visitors#registration'
  get '/privacy' => 'visitors#privacy'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
