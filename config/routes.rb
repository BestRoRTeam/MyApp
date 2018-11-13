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
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
