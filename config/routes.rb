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

  resources :books, only: [:index, :show] do
    resources :reviews, only: [:index, :create]
  end

  resource :settings
  resource :cart, only: [:show, :update], controller: 'cart'
  resources :order_items, only: [:create, :update, :destroy]
  resources :orders, only: [:index, :show]
  resources :checkout, controller: 'checkout'
end
