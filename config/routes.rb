Rails.application.routes.draw do
  resources :articles
  resources :authors
  resources :topics
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'users', to: 'users#index'
  delete 'user/:id', to: 'users#destroy'
  patch 'user/:id', to: 'users#update'
  get 'users/requests', to: 'users#request_admin'
  post 'users/approve', to: 'users#approve_user'
end