Rails.application.routes.draw do
  namespace :users do
    get 'omniauth_callbacks/facebook'
  end
  
  devise_for :users, controllers: {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  root 'homepage#index'
end
