Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :users do
    get 'omniauth_callbacks/facebook'
  end
  
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root 'homepage#index'

  scope '/categories/:category_id', as: 'category' do
    resources :books, only: [:index]
  end

  resources :books, only: [:index, :show] do
    resources :reviews, only: [:index, :create]
  end
end
