Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  devise_scope(:user) do
    get('users/checkout_login', to: 'users/registrations#checkout_login', as: 'checkout_login')
  end

  root 'homepage#index'

  resources :categories, only: [:index] do
    resources :books, only: [:index]
  end

  resources :books, only: %i[index show] do
    resources :reviews, only: %i[index create]
  end

  resource :settings, only: %i[show] do
    collection { patch :address, :user }
  end

  resource :cart, only: %i[show update], controller: 'cart'
  resources :order_items, only: %i[create update destroy]
  resources :orders, only: %i[index show]
  resources :checkout, controller: 'checkout'
end
