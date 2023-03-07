# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :html do
    resources :users
    resources :devices, only: %I[index]
    resources :firms, only: %I[index create update]
    resources :articles, only: %I[index update edit destroy]
    resources :categories do
      resources :firms
    end
  end

  defaults format: :json do
    namespace :api do
      resources :devices, only: %I[create]
      devise_scope :user do
        get '/users/profile' => 'users#profile'
      end

      resources :articles, only: %I[index create update destroy] do
        resources :comments, only: %I[index create update destroy]
        post "like" => "likes#like"
      end
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
