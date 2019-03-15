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

  scope '/categories/:category_id', as: 'category' do
    resources :books, only: [:index]
  end

  resources :books, only: [:index, :show] do
    resources :reviews, only: [:index, :create]
  end
end
