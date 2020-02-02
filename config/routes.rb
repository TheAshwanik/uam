Rails.application.routes.draw do
  root to: 'home#index'

	namespace :admin do
      resources :users
      root to: "users#index"
    end
  #root to: 'visitors#index'
 
	devise_for :users
  resources :users
end
