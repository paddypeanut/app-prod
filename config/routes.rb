Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/login'
  get 'sessions/welcome'
  resources :users, only: [:new , :create]

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'welcome', to: 'welcome#index'

  get 'authorized', to: 'sessions#page_requires_login'

  root 'sessions#welcome'

end
