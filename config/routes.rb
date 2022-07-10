# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :html do
    root to: 'pages#main'
    # get '/app-ads.txt', to: 'pages#main'

    resources :users
    resources :categories do
      resources :firms, controller: :firms
    end
    resources :firms, controller: :firms, only: %I[index create]
    resources :articles, controller: :articles
  end

  defaults format: :json do
    namespace :api do
      resources :articles, only: %I[index create]
      resources :search, only: %I[index]
      resources :firms
      resources :categories do
        get :tags
      end
    end
    scope :api do
      devise_for :users, controllers: {
        sessions: 'api/users/sessions',
        registrations: 'api/users/registrations'
      }
    end
  end
end
