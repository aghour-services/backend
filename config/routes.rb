Rails.application.routes.draw do
  defaults format: :html do
    resources :categories do
      resources :firms, controller: :firms
    end
    resources :firms, controller: :firms, only: %I[index]
  end

  defaults format: :json do
    namespace :api do
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
