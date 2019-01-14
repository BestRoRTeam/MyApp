# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tip_of_the_days
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'pages#index', as: :authenticated_root
      get 'products/statistics' => 'products#statistics'
      resources :products
      resources :categories
      resources :plans
      resources :temp_products
      post 'temp_products/submit' => 'temp_products#submit'
      namespace :api do
        resources :search, only: [:index]
      end

      get 'schedules/recurring_expenses' => 'schedules#recurring_expenses'
      get 'schedules/list' => 'schedules#list'
      resources :schedules

      resources :comments, except: %i[new edit update show destroy index]
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
