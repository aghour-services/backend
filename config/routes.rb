Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      resources :categories
    end
  end 
end
