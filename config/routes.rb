Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'users', to: 'users#index'
  delete 'user/:id', to: 'users#destroy'
  patch 'user/:id', to: 'users#update'
end