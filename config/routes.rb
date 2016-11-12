Rails.application.routes.draw do
  resources :played_games
  resources :fields
  resources :formations
  resources :goals
  resources :cards
  resources :divisions do
    resources :teams
    resources :games
  end
  resources :teams do
    resources :games
    resources :players
    member { get :lineup }
    member { post :persist_lineup }
  end
  resources :games do
    resources :goals
    resources :cards
  end
  resources :players
  resources :users do
    resources :players
    collection { get :passes }
    member { post :toggle_selected }
  end
  root to: 'visitors#index'

  get '/admin/passes' => ''
  get '/registration' => 'visitors#registration'
  get '/fields' => 'visitors#fields'
  get '/privacy' => 'visitors#privacy'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signin/facebook' => 'sessions#new', :as => :facebook_signin, provider: 'facebook'
  get '/signin/google_oauth2' => 'sessions#new', :as => :google_signin, provider: 'google_oauth2'
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
