Rails.application.routes.draw do

  root 'static_pages#home'
  get '/static_pages/home'
  get '/help', to: 'static_pages#help'#, as: 'helf'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get 'password_resets/new'
  get 'password_resets/edit'

  get 'sessions/new'

  get '/signup', to:'users#new'
  post '/signup', to:'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  resources :users do
    member do
      get :following, :followers
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#   if Rails.env.production?
##      root 'users#index'
#      root 'application#hello'
#   end

end
