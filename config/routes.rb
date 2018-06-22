Rails.application.routes.draw do
  root to: 'jobs#home'

  get '/apply',     to: 'entries#new'
  post '/apply',    to: 'entries#create'
  get '/done',      to: 'entries#done'
  get '/confirm',   to: 'entries#confirm'

  resources :jobs do
    collection do
      get 'home'
      get 'city'
      get 'city/:slug', to: 'jobs#jobs_in_city'
      get 'search'
    end
  end
  devise_for :users
end
