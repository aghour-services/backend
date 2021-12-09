Rails.application.routes.draw do
  defaults format: :html do
    resources :categories do
      resources :firms, controller: :firms
    end
    resources :firms, controller: :firms, only: %I[index]
  end

  defaults format: :json do
    scope :api do
      devise_for :users, controllers: {
        sessions: 'api/users/sessions',
        registrations: 'api/users/registrations'
      }
      resources :search, only: %I[index]
      resources :firms
      resources :categories
    end
  end
end
