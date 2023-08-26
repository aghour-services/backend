# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :html do
    resources :users
    resources :devices, only: %I[index]
    resources :firms, only: %I[index create update]
    resources :articles
    resources :categories do
      resources :firms
    end
  end

  defaults format: :json do
    namespace :api do
      resources :devices, only: %I[create]
      devise_scope :user do
        get '/users/profile' => 'users#profile'
        get '/users/:id' => 'users#show'
        put '/users' => 'users#update'
      end

      get '/articles/draft' => 'articles#draft'
      resources :articles, only: %I[index create show update destroy] do
        resources :comments, only: %I[index create update destroy]
        resource :likes, only: %I[create] do
          get :index
          delete :unlike
        end
      end
      resources :search, only: %I[index]
      resources :firms do 
        resources :ratings, only: %I[create]
      end
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
