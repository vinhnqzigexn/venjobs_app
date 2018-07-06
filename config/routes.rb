Rails.application.routes.draw do
  # resources :admins

  get '/admin/login',     to: 'admins#new'
  post '/admin/login',    to: 'admins#create'
  get '/admin/applies',   to: 'admins#index'
  delete '/logout',       to: 'admins#destroy'


  root to: 'jobs#home'
  resources :entries,     only: [:new, :create, :show, :edit, :update]
  resources :cities,      only: :index
  resources :industries,  only: :index

  get '/apply', to: 'entries#new'
  resources :jobs do
    collection do
      get 'home'
      get 'city/:search',     to: 'jobs#index'
      get 'industry/:search', to: 'jobs#index'
      get 'search'
    end
  end
  devise_for :users
end
