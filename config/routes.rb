Rails.application.routes.draw do
  resources :articles
  resources :authors
  resources :topics

  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  match '/', to: ->(env) { [200, {'Content-Type' => 'text/html'}, File.open("#{Rails.root}/app/views/static_pages/home_page.html", File::RDONLY)] }, via: :get
  get 'users', to: 'users#index'
  delete 'user/:id', to: 'users#destroy'
  patch 'user/:id', to: 'users#update'
  get 'users/requests', to: 'users#request_admin'
  post 'users/approve', to: 'users#approve_user'
  get 'search', to: 'livearticles#search'
end