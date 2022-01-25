Rails.application.routes.draw do
  defaults format: :html do
    root to: 'pages#main'

    resources :users
    resources :categories do
      resources :firms, controller: :firms
    end
    resources :firms, controller: :firms, only: %I[index create]
    resources :articles, controller: :articles
  end

  defaults format: :json do
    namespace :api do
      resources :articles, only: %I[index]
      resources :search, only: %I[index]
      resources :firms
      resources :categories
    end
    scope :api do
      devise_for :users, controllers: {
        sessions: 'api/users/sessions',
        registrations: 'api/users/registrations'
      }
    end
  end
end
