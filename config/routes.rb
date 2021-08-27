Rails.application.routes.draw do
  defaults format: :html do
    resources :categories do
      member do
        # Firm::TYPES.each do |type|
        resources "firms", controller: 'firms'
        # end
      end
    end
  end

  defaults format: :json do
    namespace :api do
      resources :firms
      resources :categories
    end
  end
end
