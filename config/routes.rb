Rails.application.routes.draw do
  root to: 'home#index'
  get 'application_dashboard_metrics/get_app_metrics'
  get 'platform_dashboard_metrics/get_platform_metrics'
  get 'home/get_application_status'
  get 'home/get_services_status'

  resources :application_dashboard_metrics
  resources :platform_dashboard_metrics
  resources :servers
  resources :applications
  resources :services

	namespace :admin do
      resources :users
      root to: "users#index"
    end
  #root to: 'visitors#index'
 
	 devise_for :users
  resources :users
end
