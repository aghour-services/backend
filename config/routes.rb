Rails.application.routes.draw do
  defaults format: :html do
    resources :categories do
      resources :firms, controller: :firms
    end
    resources :firms, controller: :firms, only: %I[index]
  end

  defaults format: :json do
    namespace :api do
      resources :firms
      resources :categories
    end
  end
end
