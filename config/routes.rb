# frozen_string_literal: true

Rails.application.routes.draw do
  mount Avo::Engine, at: Avo.configuration.root_path

  get '/', to: redirect('/admin/resources/articles')

  defaults format: :json do
    namespace :api do
      resources :devices, only: %I[create]
      resources :notifications, only: %I[index]
      devise_scope :user do
        get '/users/profile' => 'users#profile'
        get '/users/:id' => 'users#show'
        put '/users' => 'users#update'
      end
      resources :articles, only: %I[index create show update destroy] do
        resources :comments, only: %I[index create update destroy]
        resource :likes, only: %I[create] do
          get :index
          delete :unlike
        end
        collection { get :draft }
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
