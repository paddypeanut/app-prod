Rails.application.routes.draw do
  resources :customers
  resources :consignments
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/login'
  get 'sessions/welcome'
  resources :users, only: [:new , :create]

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  get 'welcome', to: 'welcome#index'

  get 'authorized', to: 'sessions#page_requires_login'

  get 'consignmentstoday', to: 'consignment_period#daily', as: 'daily_consignments'

  get 'consignmentsthisweek', to: 'consignment_period#weekly', as: 'weekly_consignments'

  get 'consignmentsthismonth', to: 'consignment_period#monthly', as: 'monthly_consignments'

  get 'search', to:'search#search', as: 'search'

  get 'search_results', to: 'search#search_results', as: 'search_results'

  get 'search_date', to: 'search#search_date', as: 'search_date'

  get 'search_date_results', to: 'search#search_date_results', as: 'search_date_results'

  root 'sessions#welcome'

  delete 'logout'  => 'sessions#destroy'

end
